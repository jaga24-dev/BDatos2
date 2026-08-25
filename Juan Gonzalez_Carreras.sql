CREATE TABLE IF NOT EXISTS carreras (
    id_carrera SERIAL PRIMARY KEY,
    clave VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    duracion_semestres INTEGER NOT NULL,
    
    CONSTRAINT chk_duracion
        CHECK (duracion_semestres > 0)
);

CREATE TABLE IF NOT EXISTS alumnos (
    id_alumno SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    id_carrera INTEGER NOT NULL,

    CONSTRAINT fk_alumno_carrera
        FOREIGN KEY (id_carrera)
        REFERENCES carreras(id_carrera)
);
