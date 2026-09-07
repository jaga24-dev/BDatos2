--ACTIVIDAD 4 PROCEDIMIENTO ALMACENADO

-- Procedimiento para cambiar el docente de un grupo
CREATE OR REPLACE PROCEDURE cambiar_docente_grupo(
    p_id_grupo INT,
    p_id_docente INT
)
LANGUAGE plpgsql
AS $$
BEGIN

    IF NOT EXISTS (SELECT 1 FROM grupos WHERE id_grupo = p_id_grupo) THEN
        RAISE EXCEPTION 'No existe el grupo con id %', p_id_grupo;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM docentes WHERE id_docente = p_id_docente) THEN
        RAISE EXCEPTION 'No existe el docente con id %', p_id_docente;
    END IF;

    UPDATE grupos
    SET id_docente = p_id_docente
    WHERE id_grupo = p_id_grupo;

    RAISE NOTICE 'El grupo % ahora está asignado al docente %', p_id_grupo, p_id_docente;
END;
$$;

CALL cambiar_docente_grupo(6, 3);

select * from grupos g 
select* from docentes 