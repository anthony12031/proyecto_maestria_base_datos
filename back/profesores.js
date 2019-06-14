var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');

router.get('/profesores', async function(req, res) {
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try {
        query = await client.query('SELECT * FROM profesores');
        await client.end;
    } catch (error) {
        return res.status(501).send(error.message);
    }
    res.send(query.rows);
});

router.get('/actualizarNotas', async function(req, res) {
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try {
        query = await client.query('select * from actualizar_notas(' + req.query.id_prof + ',' + req.query.cod_est + ',' + req.query.cod_asig + ',' + req.query.grupo_asig + ',' + req.query.nota1 + ',' + req.query.nota2 + ',' + req.query.nota3 + ')');
        await client.end;
    } catch (error) {
       return res.status(501).send(error.message);
    }
    res.send('');

    //prueba
    //http://localhost:3000/actualizarNotas?id_prof=11003&cod_est=200008&cod_asig=1003&grupo_asig='1'&nota1=3.5&nota2=3.5&nota3=3.8

});


router.get('/asignaturas_profesor', async function(req, res) {
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try {
        query = await client.query('select * from asignaturas_profesor');
        await client.end;
    } catch (error) {
        return res.status(501).send(error.message);
    }
    res.send(query.rows);

});

router.get('/consultarEstudiantes', async function(req, res) {
    const client = await pgDao.getDBConnection(connectString);
    let query = null;
    try {
        query = await client.query('select * from consultar_estudiantes(' + req.query.id_prof + ',' + req.query.cod_asig + ',' + req.query.grupo_asig + ')');
        await client.end;
    } catch (error) {
        res.status(501).send(error);
    }
    res.send(query.rows);

    //prueba
    //http://localhost:3000/consultarEstudiantes?id_prof=11004&cod_asig=1004&grupo_asig='2'

});

router.get('/consultaLibrosAutoresProf', async function(req, res) {
    const client = await pgDao.getDBConnection(connectString);
    let query = null;
    try {
        query = await client.query('select * from consultar_libros(' + req.query.isbn + ',' + req.query.titulo + ',' + req.query.edicion + ',' + req.query.autores + ')');
        await client.end;
    } catch (error) {
        res.status(501).send(error.message);
    }
    res.send(query.rows);

    //prueba
    //http://localhost:3000/consultaLibrosAutoresProf?isbn=100100100&titulo='9'&edicion=null&autores='8'

});

router.get('/consultarInfoProf', async function(req, res) {
    const client = await pgDao.getDBConnection(connectString);
    let query = null;
    try {
        query = await client.query('select * from consultar_info_profesores(' + req.query.id_prof + ')');
        await client.end;
    } catch (error) {
        res.status(501).send(error.message);
    }
    res.send(query.rows);

    //prueba
    //http://localhost:3000/consultarInfoProf?id_prof=11004

});

router.get('/actualizarInfoProf', async function(req, res) {
    const client = await pgDao.getDBConnection(connectString);
    let query = null;
    try {
        query = await client.query('select * from actualizar_info_profesores(' + req.query.id_prof + ',' + req.query.dir_prof + ',' + req.query.tel_prof + ')');
        await client.end;
    } catch (error) {
        res.status(501).send(error.message);
    }
    res.send('');

    //prueba
    //http://localhost:3000/actualizarInfoProf?id_prof=11008&dir_prof='pruebdir'&tel_prof=9999999

});

module.exports = router;