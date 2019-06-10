var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');

router.get('/coordinadores',async function(req,res){
    const client = await pgDao.getDBConnection();
    let query = null;
    try{
        query = await client.query('SELECT * FROM carreras');
    }catch(error){
        res.status(501).send(error);
    }
    res.send(query.rows);
});

router.post('/estudiantes_carrera',async function(req,res){
    
});

router.post('/actualizar',async function(req,res){
    const body = req.body;
    console.log(body);
    res.send(body);
});

module.exports = router;