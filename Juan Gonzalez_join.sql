# Facultad
CREATE table if not exists  facultades (
    id_facultad SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    decano VARCHAR(100),
    telefono VARCHAR(20)
);

#Carrera
CREATE table if not exists carreras (
    id_carrera SERIAL PRIMARY KEY,
    id_facultad INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    duracion_semestres INT NOT NULL,
    estado VARCHAR(20) DEFAULT 'ACTIVA',

    CONSTRAINT fk_carrera_facultad
        FOREIGN KEY (id_facultad)
        REFERENCES facultades(id_facultad)
);

INSERT INTO facultades (nombre, codigo, decano, telefono)
VALUES
('Facultad de Ingenieria', 'ING', 'Carlos Mendoza', '6123456789'),
('Facultad de Ciencias', 'CIE', 'Laura Ramirez', '6122345678'),
('Facultad de Administración', 'ADM', 'Roberto López', '6123456789');

INSERT INTO carreras (id_facultad, nombre, codigo, duracion_semestres)
VALUES
(1, 'Ingenieria en Desarrollo de Software', 'IDS', 8),
(1, 'Ingenieria en Tecnologías Computacionales', 'ITC', 8),
(2, 'Licenciatura en Biologia', 'BIO', 8),
(3, 'Licenciatura de Administracion', 'LAE', 8);

select * from carreras;

select 
	c.nombre,
	f.nombre
from carreras as c
inner join facultades f
on c.id_facultad = f.id_facultad 