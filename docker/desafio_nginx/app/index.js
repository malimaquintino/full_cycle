const express = require('express')
const app = express()
const port = 3000

const mysql = require('mysql')

const config = {
  host: 'db',
  user: 'root',
  password: 'mypass',
  database: 'peopledb',
}

const connection = mysql.createConnection(config);

app.get('/', async (req, res) => {
  getData(res)
})

app.listen(port, () => {
  console.log('Rodando na porta' + port)
  createTable()
})

function createTable() {
  console.log('Criando tabela e populando')
  connection.query(`CREATE TABLE IF NOT EXISTS people (name VARCHAR(50));`)
  connection.query(`INSERT INTO people (name) values ('Matheus'), ('Maria'), ('José'), ('Ana'), ('Eduardo');`)
}

function getData(res) {
  connection.query(`SELECT name from people;`, (error, results, fields)=> {
    
    let html = '<h1>Full Cycle Rocks!</h1> <ul>'
    
    for(let person of results) {      
      html += `<li>${person.name}</li>`
    }

    html += '</ul>'

    res.send(html)
  })
}