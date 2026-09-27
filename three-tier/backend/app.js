const express = require('express');
const mysql = require('mysql2');

const app = express();
const PORT = process.env.PORT || 4000;

app.use(express.json());

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

// Test backend + database
app.get('/api', (req, res) => {
  db.query('SELECT NOW() AS currentTime', (err, results) => {
    if (err) return res.status(500).send(err);

    res.json({
      message: "Backend connected to DB!",
      time: results[0].currentTime
    });
  });
});

// Create user
app.post('/api/users', (req, res) => {
  const { name, email } = req.body;

  if (!name || !email) {
    return res.status(400).json({
      message: "Name and email are required"
    });
  }

  const sql = 'INSERT INTO users (name, email) VALUES (?, ?)';

  db.query(sql, [name, email], (err, result) => {
    if (err) {
      return res.status(500).json({
        message: "Database error",
        error: err.message
      });
    }

    res.status(201).json({
      message: "User created successfully",
      user: {
        id: result.insertId,
        name: name,
        email: email
      }
    });
  });
});

// Get all users
app.get('/api/users', (req, res) => {
  db.query('SELECT * FROM users', (err, results) => {
    if (err) {
      return res.status(500).json({
        message: "Database error",
        error: err.message
      });
    }

    res.json(results);
  });
});

app.listen(PORT, () => {
  console.log(`Backend running on port ${PORT}`);
});
