var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');

router.get('/coordinadores',async function(req,res){
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try{
        query = await client.query('SELECT * FROM carreras');
    }catch(error){
        res.status(501).send(error.message);
    }
    res.send(query.rows);
});

router.get('/estudiantes_carrera',async function(req,res){
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try{
        query = await client.query('SELECT * FROM consultar_estudiantes_carrera');
    }catch(error){
        res.status(501).send(error.message);
    }
    res.send(query.rows);
});

router.post('/estudiantes_carrera',async function(req,res){
    const body = req.body;
    debugger;
    res.status(501).send('updating');
});

router.post('/actualizar',async function(req,res){
    const body = req.body;
    console.log(body);
    res.send(body);
});

module.exports = router;