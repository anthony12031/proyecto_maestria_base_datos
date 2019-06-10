var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');

const connectString = "postgresql://postgres:juegosxbox@localhost:5432/Ingenieria";

router.get('/profesores',async function(req,res){
    const client = await pgDao.getCurrentConnection(connectString);
    let query = null;
    try{
        query = await client.query('SELECT * FROM profesores');
        await client.end;
    }catch(error){
        res.status(501).send(error.message);
    }
    res.send(query.rows);
});

module.exports = router;