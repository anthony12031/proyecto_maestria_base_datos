const { Client } = require('pg')
//const connectionString = "postgresql://postgres:juegosxbox@localhost:5432/Ingenieria"

let client = null;
async function getDBConnection(connectionString){
    if(client)
        client.end();
    client = new Client({
        connectionString : connectionString
    }
    )
    await client.connect();
    return client;
}

async function getCurrentConnection(){
    return client;
}


module.exports = {
    getDBConnection,
    getCurrentConnection
}