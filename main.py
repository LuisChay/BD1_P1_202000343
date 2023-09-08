from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
import json
import pandas as pd
from flask_cors import CORS
from config import config
import sys

app = Flask(__name__)
CORS(app)
conexion = MySQL(app)

#Rutas iniciales

@app.route('/', methods=['GET'])
def rutaInicial():

    
        return("Ruta inicial")    


@app.route('/', methods=['POST'])
def rutaPost():
    objeto = {"Mensaje":"Prueba"}
    return(jsonify(objeto))

#Rutas proyecto

@app.route('/consulta1', methods=['GET'])
def consulta1():
    return("Ruta inicial")

@app.route('/consulta2', methods=['GET'])
def consulta2():
    return("Ruta inicial")

@app.route('/consulta3', methods=['GET'])
def consulta3():
    return("Ruta inicial")

@app.route('/consulta4', methods=['GET'])
def consulta4():
    return("Ruta inicial")

@app.route('/consulta5', methods=['GET'])
def consulta5():
    return("Ruta inicial")

@app.route('/consulta6', methods=['GET'])
def consulta6():
    return("Ruta inicial")

@app.route('/consulta7', methods=['GET'])
def consulta7():
    return("Ruta inicial")

@app.route('/consulta8', methods=['GET'])
def consulta8():
    return("Ruta inicial")

@app.route('/consulta9', methods=['GET'])
def consulta9():
    return("Ruta inicial")

@app.route('/consulta10', methods=['GET'])
def consulta10():
    return("Ruta inicial")

@app.route('/consulta11', methods=['GET'])
def consulta12():
    return("Ruta inicial")


@app.route('/eliminarmodelo', methods=['GET'])
def eliminarmodelo():
    return("Ruta inicial")

@app.route('/crearmodelo', methods=['GET'])
def crarmodelo():
    return("Ruta inicial")

@app.route('/cargarmodelo', methods=['GET'])
def cargarmodelo():
        cursor = conexion.connection.cursor()
        cursor.execute("""
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
                       """)
        conexion.connection.commit()
        
        departamenosFile = pd.read_csv('csv/departamentos.csv',encoding="utf8",skiprows=[0])
        for index, row in departamenosFile.iterrows():
            cursor.execute("INSERT INTO departamento (id_departamento, nombre_departamento) VALUES (%s,%s);", (int(row[0]), row[1]))
        conexion.connection.commit()
        return("Ruta inicial")

           

if __name__ == "__main__":
    app.config.from_object(config['development'])
    app.run(port=4000)
    #host="0.0.0.0", port=4000, debug=True