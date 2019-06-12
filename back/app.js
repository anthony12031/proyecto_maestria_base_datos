// string conexion a base datos
//"postgresql://postgres:juegosxbox@localhost:5432/sincronik"

var express = require('express');
var cors = require('cors');
var app = express();
const bodyParser = require('body-parser');
const pgDao = require("./pgDao");
var estudiantes = require('./estudiantes');
var profesores = require('./profesores');
var coordinadores = require('./coordinadores');
var bibliotecarios = require('./bibliotecarios');

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json());

app.post('/login',async function(req,res){
  const {user,password,dataBase} = req.body;
  const connectString = `postgresql://${user}:${password}@localhost:5432/${dataBase}`;
  try{
    const client = await pgDao.getDBConnection(connectString);
    res.send('Conectado a la base de datos');
  }catch(err){
    res.status(501).send("usuario o contraseña incorrecto");
  }
});

// consultas de estudiantes
app.use('/', estudiantes);
// consultas de profesores
app.use('/', profesores);
// consultas de coordinadores
app.use('/', coordinadores);
// consultas de bibliotecarios
app.use('/', bibliotecarios);

app.use('*', function(req, res) {
    res.status(404).send('ruta no encontrada');
})

app.listen(3000, function() {
    console.log('proyecto final base datos corriendo en puerto ' + 3000);
});