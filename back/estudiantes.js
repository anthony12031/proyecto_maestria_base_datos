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

router.get('/notasEstudiantes', async function(req, res) {
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try {
        query = await client.query('select * from consultar_notas_estudiante');
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
        query = await client.query('select * from consulta_libros_autores');
        await client.end;
    } catch (error) {
        return res.status(501).send(error);
    }
    res.send(query.rows);
});

router.get('/consultaPrestamos', async function(req, res) {
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try {
        query = await client.query('select * from consultar_prestamos');
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