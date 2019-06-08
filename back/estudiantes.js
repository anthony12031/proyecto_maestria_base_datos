var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');

const connectString = "postgresql://postgres:juegosxbox@localhost:5432/Ingenieria";

router.get('/estudiantes',async function(req,res){
    const client = await pgDao.getDBConnection(connectString);
    let query = null;
    try{
        query = await client.query('SELECT * FROM estudiantes');
        await client.end;
    }catch(error){
        res.status(501).send(error);
    }
    res.send(query.rows);
});

module.exports = router;