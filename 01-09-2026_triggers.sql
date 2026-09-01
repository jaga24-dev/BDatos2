--01-09-2026 triggers
select * from grupos g 
select * from materias 
select * from pagos 
/* =========================================================
   1. TRIGGER - VALIDAR CUPO DEL GRUPO
   ========================================================= */

CREATE OR REPLACE FUNCTION validar_cupo_grupo()
RETURNS TRIGGER
AS $$
DECLARE
    total_inscritos INT;
    limite_grupo INT;
BEGIN
	--obtener el total de inscritos
    SELECT COUNT(*)
    INTO total_inscritos
    FROM inscripciones
    WHERE id_grupo = NEW.id_grupo
      AND estado = 'INSCRITO';

	--TOTAL cupo maximo
    SELECT cupo_maximo
    INTO limite_grupo
    FROM grupos
    WHERE id_grupo = NEW.id_grupo;

	--validar que se sobre pase del cupo maximo
    IF total_inscritos >= limite_grupo THEN
        RAISE EXCEPTION
        'No se puede realizar la inscripción. El grupo está lleno.';
    END IF;


    RETURN NEW;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_validar_cupo_grupo
BEFORE INSERT
ON inscripciones
FOR EACH ROW
EXECUTE FUNCTION validar_cupo_grupo();



/* =========================================================
   PRUEBA DEL TRIGGER
   ========================================================= */

SELECT
    g.id_grupo,
    m.nombre AS materia,
    g.grupo,
    g.cupo_maximo,
    COUNT(i.id_inscripcion) AS alumnos_inscritos
FROM grupos g
INNER JOIN materias m
    ON g.id_materia = m.id_materia
LEFT JOIN inscripciones i
    ON g.id_grupo = i.id_grupo
    AND i.estado = 'INSCRITO'
GROUP BY
    g.id_grupo,
    m.nombre,
    g.grupo,
    g.cupo_maximo
ORDER BY g.id_grupo;


/*
Ejemplo:

INSERT INTO inscripciones
(id_estudiante, id_grupo, id_periodo)
VALUES
(4, 4, 2);
*/


/* =========================================================
   ACTIVIDDAD TRIGGER - EVITAR EXCESO DE MONTO PAGOS 20,000
   ========================================================= */
CREATE OR REPLACE FUNCTION validar_monto_pago()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.monto > 20000 THEN
        RAISE EXCEPTION 'El monto supera el límite permitido.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_validar_monto_pago
BEFORE INSERT
ON pagos
FOR EACH ROW
EXECUTE FUNCTION validar_monto_pago();


select * from pagos p 
/* =========================================================
   PRUEBA
   Juan ya tiene un pago de inscripción del periodo 2.
   ========================================================= */

/*
INSERT INTO pagos
(
    id_estudiante,
    id_periodo,
    concepto,
    monto,
    metodo_pago,
    referencia
)
VALUES
(
    5,
    1,
    'Inscripción',
    20000,
    'Tarjeta',
    'REF999'
);
*/



















