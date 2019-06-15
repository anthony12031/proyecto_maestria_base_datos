var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');

router.get('/libros',async function(req,res){
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try{
        query = await client.query('SELECT * FROM libros');
        await client.end;
    }catch(error){
        return res.status(501).send(error.message);
    }
    res.send(query.rows);
});

router.post('/update_libros',async function(req,res){
    const body = req.body;
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try{
        query = await client.query('INSERT INTO libros(isbn,titulo,edicion) VALUES ($1,$2,$3)',[body.isbn,body.titulo,body.edicion]);
        await client.end;
    }catch(error){
        return res.status(501).send(error.message);
    }
    res.send([]);
});

router.post('/ejemplares',async function(req,res){
    const body = req.body;
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try{
        query =   await client.query('SELECT * FROM consultar_ejemplares($1)',[body.isbn]);
        await client.end;
    }catch(error){
        return res.status(501).send(error.message);
    }
    res.send(query.rows);
});





module.exports = router;