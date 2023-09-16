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

--Creacion de tablas temporales
CREATE TEMPORARY TABLE cargotemp (
    id_cargo INT NOT NULL PRIMARY KEY,
    cargo VARCHAR(100) NOT NULL
);

CREATE TEMPORARY TABLE departamentotemp (
    id_departamento INT NOT NULL  PRIMARY KEY,
    nombre_departamento VARCHAR(30) NOT NULL
);

CREATE TEMPORARY TABLE mesatemp (
    id_mesa INT NOT NULL  PRIMARY KEY,
    id_departamento INT NOT NULL
);

CREATE TEMPORARY TABLE  ciudadanotemp (
    dpi VARCHAR(13) NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    edad INT NOT NULL,
    genero VARCHAR(1) NOT NULL
);

CREATE TEMPORARY TABLE partidotemp (
    id_partido INT NOT NULL  PRIMARY KEY,
    nombre_partido VARCHAR(100) NOT NULL,
    siglas VARCHAR(30) NOT NULL,
    fundacion DATE NOT NULL
);

CREATE TEMPORARY TABLE candidatotemp (
    id_candidato INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    id_cargo INT NOT NULL,
    id_partido INT NOT NULL
);

CREATE TEMPORARY TABLE vototemp (
    id_voto INT NOT NULL,
    id_candidato INT NOT NULL,
    dpi VARCHAR(13) NOT NULL,
    id_mesa INT NOT NULL,
    fechahora_voto DATETIME NOT NULL
);

-- Insercion de datos a tablas temporales y luego a tablas del modelo
INSERT INTO departamentotemp (id_departamento, nombre_departamento) VALUES (%s,%s);
INSERT INTO departamento (id_departamento, nombre_departamento) SELECT id_departamento, nombre_departamento FROM departamentotemp;

INSERT INTO cargotemp (id_cargo, cargo) VALUES (%s,%s);
INSERT INTO cargo (id_cargo, cargo) SELECT id_cargo, cargo FROM cargotemp;

INSERT INTO partidotemp (id_partido, nombre_partido, siglas, fundacion) VALUES (%s,%s,%s,%s);
INSERT INTO partido (id_partido, nombre_partido, siglas, fundacion) SELECT id_partido, nombre_partido, siglas, fundacion FROM partidotemp;

INSERT INTO mesatemp (id_mesa, id_departamento) VALUES (%s,%s);
INSERT INTO mesa (id_mesa, id_departamento) SELECT id_mesa, id_departamento FROM mesatemp;

INSERT INTO ciudadanotemp (dpi, nombre, apellido, direccion, telefono, edad, genero) VALUES (%s,%s,%s,%s,%s,%s,%s);
INSERT INTO ciudadano (dpi, nombre, apellido, direccion, telefono, edad, genero) SELECT dpi, nombre, apellido, direccion, telefono, edad, genero FROM ciudadanotemp;

INSERT INTO candidatotemp (id_candidato, nombre, fecha_nacimiento, id_partido, id_cargo) VALUES (%s,%s,%s,%s,%s);
INSERT INTO candidato (id_candidato, nombre, fecha_nacimiento, id_cargo, id_partido) SELECT id_candidato, nombre, fecha_nacimiento, id_cargo, id_partido FROM candidatotemp;

INSERT INTO vototemp (id_voto, id_candidato, dpi, id_mesa, fechahora_voto) VALUES (%s,%s,%s,%s,%s);
SELECT * FROM voto WHERE id_voto = %s;
SELECT * FROM vototemp;
INSERT INTO voto (id_voto, id_candidato, dpi, id_mesa, fechahora_voto) VALUES (%s,%s,%s,%s,%s);
INSERT INTO detalle_voto (id_voto, id_candidato) VALUES (%s,%s);

-- CONSULTAS
-- Consulta 1
SELECT P.nombre_partido AS partido, (SELECT C1.nombre FROM candidato C1 WHERE C1.id_partido = P.id_partido AND C1.id_cargo = 1) AS nombre_presidente, (SELECT C2.nombre FROM candidato C2 WHERE C2.id_partido = P.id_partido AND C2.id_cargo = 2) AS nombre_vicepresidente
FROM partido P
WHERE P.nombre_partido <> 'NULO';
-- Consulta 2
SELECT COUNT(*) AS cuenta, p.nombre_partido AS partido
FROM candidato c 
inner join partido p on c.id_partido = p.id_partido 
inner join cargo ca on c.id_cargo = ca.id_cargo
WHERE c.id_cargo IN (3, 4, 5)
GROUP BY c.id_partido;
-- Consulta 3
SELECT p.nombre_partido AS partido, c.nombre AS candidato
FROM candidato c
INNER JOIN partido p ON c.id_partido = p.id_partido
WHERE c.id_cargo = 6;
-- Consulta 4
SELECT COUNT(c.nombre) as cuenta, p.nombre_partido AS partido
FROM candidato c 
INNER JOIN partido p on c.id_partido = p.id_partido 
INNER JOIN cargo ca on c.id_cargo = ca.id_cargo
WHERE c.id_cargo IN (1, 2,3,4,5,6)
GROUP BY c.id_partido;
-- Consulta 5 
SELECT COUNT(*) AS numero_de_registros, d.nombre_departamento AS departamento
FROM voto dv
INNER JOIN mesa m ON dv.id_mesa = m.id_mesa
INNER JOIN departamento d ON m.id_departamento = d.id_departamento
GROUP BY d.nombre_departamento
-- Consulta 6
SELECT COUNT(*) AS numero_de_registros
FROM voto
WHERE id_candidato = -1;
-- Consulta 7
SELECT c.edad, COUNT(*) AS frecuencia
FROM voto v
INNER JOIN ciudadano c ON v.dpi = c.dpi
GROUP BY c.edad
ORDER BY COUNT(*) DESC
LIMIT 10;
-- Consulta 8
SELECT c1.nombre AS nombre_presidente, c2.nombre AS nombre_vicepresidente, COUNT(*) AS cantidad_de_votos
FROM candidato as c1
INNER JOIN candidato as c2 ON c1.id_partido = c2.id_partido AND (c1.id_cargo = 1 AND c2.id_cargo = 2)
INNER JOIN detalle_voto as dv ON c1.id_candidato = dv.id_candidato
GROUP BY nombre_presidente, nombre_vicepresidente
ORDER BY cantidad_de_votos DESC
LIMIT 10;
-- Consulta 9
SELECT m.id_mesa AS numero_de_mesa, d.nombre_departamento AS departamento, COUNT(*) AS cantidad_de_votos
FROM voto dv
INNER JOIN mesa m ON dv.id_mesa = m.id_mesa
INNER JOIN departamento d ON m.id_departamento = d.id_departamento
GROUP BY m.id_mesa, d.nombre_departamento
ORDER BY cantidad_de_votos DESC
LIMIT 5;
-- Consulta 10
SELECT DATE_FORMAT(dv.fechahora_voto, '%H:%i') AS hora, COUNT(*) AS cantidad_de_votos
FROM voto dv
GROUP BY DATE_FORMAT(dv.fechahora_voto, '%H:%i')
ORDER BY cantidad_de_votos DESC
LIMIT 5;
-- Consulta 11
SELECT c.genero AS genero, COUNT(*) AS cantidad_de_votos
FROM voto dv
INNER JOIN ciudadano c ON c.dpi = dv.dpi
GROUP BY c.genero;
--Eliminar tablas
DROP TABLE IF EXISTS cargo, ciudadano, candidato, partido, voto, detalle_voto, mesa, departamento;