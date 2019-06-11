var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');

const connectString = "postgresql://postgres:bartolomeo@localhost:5432/cienciasEducacion";

router.get('/profesores', async function(req, res) {
    const client = await pgDao.getDBConnection(connectString);
    let query = null;
    try {
        query = await client.query('SELECT * FROM profesores');
        await client.end;
    } catch (error) {
        res.status(501).send(error);
    }
    res.send(query.rows);
});

router.get('/actualizarNotas', async function(req, res) {
    const client = await pgDao.getDBConnection(connectString);
    let query = null;
    try {
        query = await client.query('select * from actualizar_notas(' + req.query.id_prof + ',' + req.query.cod_est + ',' + req.query.cod_asig + ',' + req.query.grupo_asig + ',' + req.query.nota1 + ',' + req.query.nota2 + ',' + req.query.nota3 + ')');
        await client.end;
    } catch (error) {
        res.status(501).send(error);
    }
    res.send('');

    //prueba
    //http://localhost:3000/actualizarNotas?id_prof=11003&cod_est=200008&cod_asig=1003&grupo_asig='1'&nota1=3.5&nota2=3.5&nota3=3.8

});

module.exports = router;