create table if not exists estudiantes (
	id_estudiante SERIAL primary key,
	matricula VARCHAR(20) unique not null,
	nombre VARCHAR(100) not null,
	apellido VARCHAR(100) not null,
	email VARCHAR(100) unique,
	telefono VARCHAR(20),
	fecha_nacimiento DATE,
	id_carrera INT not null,
	fecha_ingreso DATE default CURRENT_DATE,
	estado VARCHAR(20) default 'ACTIVO',
	
	constraint fk_estudiantes_carrera
		foreign key (id_carrera)
		references carreras(id_carrera)
);

insert into estudiantes
(matricula, nombre, apellido, email, telefono, fecha_nacimiento, id_carrera)
values 
('20260001', 'Juan','Peréz', 'Juan@universidad.mx', '6121111111', '2005-06-10', 5),
('20260002', 'Maria','Lopez', 'maria@universidad.mx', '6122222222', '2004-08-15', 5),
('20260003', 'Carlos','Ramírez', 'carlos@universidad.mx', '6123333333', '2005-01-20', 6),
('20260004', 'Ana','Torres', 'ana@universidad.mx', '6124444444', '2004-11-03', 7);


SELECT 
    e.id_estudiante,
    e.matricula,
    e.nombre,
    e.apellido,
    e.email,
    c.nombre,
    c.codigo,
    c.duracion_semestres
FROM estudiantes e
INNER JOIN carreras c
    ON e.id_carrera = c.id_carrera;
