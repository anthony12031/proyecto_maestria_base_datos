var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');


router.get('/estudiantes', async function(req, res) {
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try {
        query = await client.query('SELECT * FROM estudiantes');
        await client.end;
    } catch (error) {
        return res.status(501).send(error);
    }
    res.send(query.rows);
});

router.get('/notasEstudiantes/:cod_est', async function(req, res) {
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try {
        query = await client.query('select * from consultar_notas_estudiante(' + req.params.cod_est + ')');
        await client.end;
    } catch (error) {
        return res.status(501).send(error);
    }
    res.send(query.rows);
});

router.get('/consultaLibrosAutores', async function(req, res) {
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try {
        query = await client.query('select * from consultar_libros(' + req.query.isbn + ',' + req.query.titulo + ',' + req.query.edicion + ',' + req.query.autores + ')');
        await client.end;
    } catch (error) {
        return res.status(501).send(error);
    }
    res.send(query.rows);

    //prueba
    //http://localhost:3000/consultaLibrosAutores?isbn=100100100&titulo='9'&edicion=null&autores='8'

});

router.get('/consultaPrestamos/:cod_est', async function(req, res) {
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try {
        query = await client.query('select * from consultar_prestamos(' + req.params.cod_est + ')');
        await client.end;
    } catch (error) {
        return res.status(501).send(error);
    }
    res.send(query.rows);

});

router.post('/prueba', async function(req, res) {
    const body = req.body;
    console.log(body);
    res.send(body);
});

module.exports = router;