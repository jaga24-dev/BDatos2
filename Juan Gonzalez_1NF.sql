CREATE TABLE IF NOT EXISTS alumnos (
    id_alumno int PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    carrera VARCHAR(100) NOT NULL,
    materias VARCHAR(100) NOT NULL
);

INSERT INTO alumnos (id_alumno, nombre, carrera, materias) VALUES
(1, 'Ana', 'Software', 'Base de Datos, Programación Web'),
(2, 'Carlos', 'Software', 'Matemáticas, Base de Datos'),
(3, 'María', 'Inteligencia Artificial', 'Programación Web, Matemáticas'),
(4, 'Pedro', 'Software', 'Redes, Base de Datos');

SELECT * FROM alumnos;

select nombre, materias from alumnos where materias ilike '%base de datos%';