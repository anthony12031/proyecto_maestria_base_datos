// string conexion a base datos
//"postgresql://postgres:juegosxbox@localhost:5432/sincronik"

var express = require('express');
var cors = require('cors');
var app = express();
var pgDao = require('./pgDao');
app.use(cors());

const connectString = "postgresql://postgres:juegosxbox@localhost:5432/Ingenieria";

app.get('/', function(req, res) {
  res.send('Hola Mundo!');
});

app.get('/estudiantes',async function(req,res){
    const client = await pgDao.getDBConnection(connectString);
    let query = null;
    try{
        query = await client.query('SELECT * FROM estudiantes');
        await client.end;
    }catch(error){
        res.status(501).send(error);
    }
    res.send(query.rows)
});



app.listen(3000, function() {
  console.log('proyecto final base datos corriendo en puerto '+3000);
});