--Creacion base de datos
CREATE DATABASE IF NOT EXISTS proyecto1_bases;

--Creacion de tablas del modelo
CREATE TABLE IF NOT EXISTS cargo (
    id_cargo INT NOT NULL PRIMARY KEY,
    cargo VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS departamento (
    id_departamento INT NOT NULL  PRIMARY KEY,
    nombre_departamento VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS mesa (
    id_mesa INT NOT NULL  PRIMARY KEY,
    id_departamento INT NOT NULL, 
	FOREIGN KEY (id_departamento)  REFERENCES departamento(id_departamento)
);

CREATE TABLE IF NOT EXISTS ciudadano (
    dpi VARCHAR(13) NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    edad INT NOT NULL,
    genero VARCHAR(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS partido (
    id_partido INT NOT NULL  PRIMARY KEY,
    nombre_partido VARCHAR(100) NOT NULL,
    siglas VARCHAR(30) NOT NULL,
    fundacion DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS candidato (
    id_candidato INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_cargo INT NOT NULL,
    id_partido INT NOT NULL, 
	FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo),
    FOREIGN KEY (id_partido) REFERENCES partido(id_partido)
);


CREATE TABLE IF NOT EXISTS voto (
    id_voto INT NOT NULL  PRIMARY KEY,
    fechahora_voto DATE NOT NULL,
    dpi VARCHAR(13) NOT NULL,
    id_mesa INT NOT NULL,
    FOREIGN KEY (dpi) REFERENCES ciudadano(dpi),
    FOREIGN KEY (id_mesa) REFERENCES mesa(id_mesa)
);

CREATE TABLE IF NOT EXISTS detalle_voto (
    id_detalle INT NOT NULL  PRIMARY KEY,
    id_voto INT NOT NULL, 
    id_candidato INT NOT NULL,  
    FOREIGN KEY (id_voto)  REFERENCES voto(id_voto),
    FOREIGN KEY (id_candidato) REFERENCES candidato(id_candidato)
);

--Eliminar tablas
DROP TABLE IF EXISTS cargo, ciudadano, candidato, partido, voto, detalle_voto, mesa, departamento;

--Mostrar tablas si es necesario
show databases;
