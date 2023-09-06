from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
import json

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
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta2', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta3', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta4', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta5', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta6', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta7', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta8', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta9', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta10', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/consulta11', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/eliminartabtemp', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/cargartabtemp', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/eliminarmodelo', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/crearmodelo', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

@app.route('/cargarmodelo', methods=['GET'])
def rutaInicial():
    return("Ruta inicial")

           

if __name__ == "__main__":
    app.config.from_object(config['development'])
    app.run()
    #host="0.0.0.0", port=4000, debug=True