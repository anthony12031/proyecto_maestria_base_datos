const { Client } = require('pg')
//const connectionString = "postgresql://postgres:juegosxbox@localhost:5432/Ingenieria"

let client = null;
async function getDBConnection(connectionString){
    client = new Client({
        connectionString : connectionString
    }
    )
    await client.connect()
    return client;
}


module.exports = {
    getDBConnection
}