var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');
var moment = require('moment');

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
        return res.status(501).send(error.message);
    }
    res.send(query.rows);
});

router.post('/estudiantes_carrera',async function(req,res){
    const body = req.body;
    const f_nac = moment(req.f_nac).format("YYYYMMDD");
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try{
        const queryString = `select * FROM insert_student($1::bigint,$2,$3::varchar,$4,$5,to_date($6,'YYYYMMDD'))`;
        query = await client.query(queryString,[body.cod_e,body.nom_e,body.dir_e  ,body.tel_e,body.cod_carr,f_nac]);
    }catch(error){
        return res.status(501).send(error.message);
    }
    res.send(query.rows);
});

router.put('/estudiantes_carrera',async function(req,res){
    const body = req.body;
    const f_nac = moment(req.f_nac).format("YYYYMMDD");
    const client = await pgDao.getCurrentConnection();
    let query = null;
    try{
        const queryString = `UPDATE estudiantes SET nom_e = $1 ,dir_e= $2, tel_e= $3, cod_carr = $4 , f_nac = $5 WHERE cod_e = $6`;
        query = await client.query(queryString,[body.nom_e,body.dir_e  ,body.tel_e,body.cod_carr,f_nac,body.cod_e]);
    }catch(error){
        return res.status(501).send(error.message);
    }
    res.send(query.rows);
});

router.post('/actualizar',async function(req,res){
    const body = req.body;
    console.log(body);
    res.send(body);
});

module.exports = router;