--27-08-2026

CREATE table if not exists grupos ( 
	id_grupo SERIAL PRIMARY KEY, 
	id_materia INT NOT NULL, 
	id_docente INT NOT NULL, 
	id_periodo INT NOT NULL, 
	id_aula INT NOT NULL, 
	grupo VARCHAR(10) NOT NULL, 
	horario VARCHAR(100), 
	cupo_maximo INT DEFAULT 30,

CONSTRAINT fk_grupo_materia
    FOREIGN KEY (id_materia)
    REFERENCES materias(id_materia),

CONSTRAINT fk_grupo_docente
    FOREIGN KEY (id_docente)
    REFERENCES docentes(id_docente),

CONSTRAINT fk_grupo_periodo
    FOREIGN KEY (id_periodo)
    REFERENCES periodos_academicos(id_periodo),

CONSTRAINT fk_grupo_aula
    FOREIGN KEY (id_aula)
    REFERENCES aulas(id_aula)
);

INSERT INTO grupos (id_materia, id_docente, id_periodo, id_aula, grupo, horario, cupo_maximo) 
VALUES 
(5, 1, 2, 1, 'A', 'Lunes y Miércoles 08:00-10:00', 30),
(6, 2, 2, 2, 'A', 'Martes y Jueves 10:00-12:00', 35),
(7, 1, 2, 3, 'A', 'Lunes y Miércoles 12:00-14:00', 25)


CREATE table if not exists inscripciones ( 
	id_inscripcion SERIAL PRIMARY KEY,
	id_estudiante INT NOT NULL,
	id_grupo INT NOT NULL,
	id_periodo INT NOT NULL,
	fecha_inscripcion DATE DEFAULT CURRENT_DATE,
	estado VARCHAR(20) DEFAULT 'INSCRITO',

CONSTRAINT fk_inscripcion_estudiante
    FOREIGN KEY (id_estudiante)
    REFERENCES estudiantes(id_estudiante),

CONSTRAINT fk_inscripcion_grupo
    FOREIGN KEY (id_grupo)
    REFERENCES grupos(id_grupo),

CONSTRAINT fk_inscripcion_periodo
    FOREIGN KEY (id_periodo)
    REFERENCES periodos_academicos(id_periodo),

CONSTRAINT uq_estudiante_grupo
    UNIQUE(id_estudiante, id_grupo)
);

INSERT INTO inscripciones (id_estudiante, id_grupo, id_periodo) 
VALUES 
(5, 4, 2), (5, 5, 2), (5, 6, 2),
(6, 4, 2), (6, 5, 2), (7, 4, 2);


CREATE table if not exists  calificaciones ( 
	id_calificacion SERIAL PRIMARY KEY,
	id_inscripcion INT NOT NULL,
	calificacion DECIMAL(5,2),
	fecha_registro DATE DEFAULT CURRENT_DATE,
	observaciones TEXT,
	tipo_evaluacion VARCHAR(50),

CONSTRAINT fk_calificacion_inscripcion
    FOREIGN KEY (id_inscripcion)
    REFERENCES inscripciones(id_inscripcion),

CONSTRAINT chk_calificacion
    CHECK (calificacion >= 0 AND calificacion <= 100)
);

INSERT INTO calificaciones (id_inscripcion, calificacion, observaciones, tipo_evaluacion) 
values
(13, 90, 'Buen desempeño', 'Final'), (14, 85, 'Cumplió con las actividades', 'Final'),
(15, 95, 'Excelente desempeño', 'Final'), (16, 78, 'Debe mejorar prácticas', 'Final'),
(17, 88, 'Buen desempeño', 'Final');


CREATE table if not exists pagos ( 
	id_pago SERIAL PRIMARY KEY,
	id_estudiante INT NOT NULL,
	id_periodo INT NOT NULL,
	concepto VARCHAR(100) NOT NULL,
	monto DECIMAL(12,2) NOT NULL,
	fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	metodo_pago VARCHAR(30), referencia VARCHAR(100),
	estado VARCHAR(20) DEFAULT 'PAGADO',

CONSTRAINT fk_pago_estudiante
    FOREIGN KEY (id_estudiante)
    REFERENCES estudiantes(id_estudiante),

CONSTRAINT fk_pago_periodo
    FOREIGN KEY (id_periodo)
    REFERENCES periodos_academicos(id_periodo),

CONSTRAINT chk_monto
    CHECK (monto > 0)
);

INSERT INTO pagos (id_estudiante, id_periodo, concepto, monto, metodo_pago, referencia) 
VALUES 
(5, 2, 'Inscripción', 3500.00, 'Tarjeta', 'REF001'),
(6, 2, 'Inscripción', 3500.00, 'Transferencia', 'REF002'),
(7, 2, 'Inscripción', 3500.00, 'Efectivo', 'REF003');


--que materias esta cursando juan
select * from estudiantes e 

select * from materias m 

--que alumnos estan inscritos en la materia




