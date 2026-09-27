const express = require('express');
const axios = require('axios');

const app = express();
const PORT = process.env.PORT || 3000;

const backendUrl =
  process.env.BACKEND_URL || 'http://backend-service:4000';

app.get('/', (req, res) => {
  res.send(`
    <html>
      <head>
        <title>Three Tier Application</title>
      </head>

      <body>
        <h1>User Registration</h1>

        <form action="/create-user" method="POST">
          <label>Name:</label>
          <input type="text" name="name" required />

          <br><br>

          <label>Email:</label>
          <input type="email" name="email" required />

          <br><br>

          <button type="submit">Save User</button>
        </form>

        <br>

        <a href="/users">View Users</a>
      </body>
    </html>
  `);
});

// Receive form data and send it to backend
app.post('/create-user', express.urlencoded({ extended: true }), async (req, res) => {
  try {
    const response = await axios.post(
      `${backendUrl}/api/users`,
      {
        name: req.body.name,
        email: req.body.email
      }
    );

    res.send(`
      <h1>User Created Successfully!</h1>

      <p>ID: ${response.data.user.id}</p>
      <p>Name: ${response.data.user.name}</p>
      <p>Email: ${response.data.user.email}</p>

      <br>

      <a href="/">Add another user</a>
      <br>
      <a href="/users">View all users</a>
    `);

  } catch (err) {
    res.status(500).send(
      'Error calling backend: ' + err.message
    );
  }
});

// Get users from backend
app.get('/users', async (req, res) => {
  try {
    const response = await axios.get(`${backendUrl}/api/users`);

    let html = `
      <h1>Users</h1>
      <table border="1" cellpadding="10">
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Email</th>
        </tr>
    `;

    response.data.forEach(user => {
      html += `
        <tr>
          <td>${user.id}</td>
          <td>${user.name}</td>
          <td>${user.email}</td>
        </tr>
      `;
    });

    html += `
      </table>

      <br>
      <a href="/">Back</a>
    `;

    res.send(html);

  } catch (err) {
    res.status(500).send(
      'Error getting users: ' + err.message
    );
  }
});

app.listen(PORT, () => {
  console.log(`Frontend running on port ${PORT}`);
});
