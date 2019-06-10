var express = require('express');
var router = express.Router();
var pgDao = require('./pgDao');



router.get('/estudiantes',async function(req,res){
    const client = await pgDao.getCurrentConnection(connectString);
    let query = null;
    try{
        query = await client.query('SELECT * FROM estudiantes');
        await client.end;
    }catch(error){
        res.status(501).send(error.message);
    }
    res.send(query.rows);
});

module.exports = router;