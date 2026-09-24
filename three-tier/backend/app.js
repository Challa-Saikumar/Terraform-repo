const express = require('express');
const mysql = require('mysql2');
const app = express();
const PORT = process.env.PORT || 4000;

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

app.get('/api', (req, res) => {
  db.query('SELECT NOW() AS current_time', (err, results) => {
    if (err) return res.status(500).send(err);
    res.json({ message: "Backend connected to DB!", time: results[0].current_time });
  });
});

app.listen(PORT, () => {
  console.log(`Backend running on port ${PORT}`);
});
