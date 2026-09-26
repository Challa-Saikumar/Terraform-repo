const express = require('express');
const axios = require('axios');
const app = express();
const PORT = process.env.PORT || 3000;

// Root route
app.get('/', (req, res) => {
  res.send('<h1>Welcome to the Frontend!</h1><p>Go to /api to fetch backend data.</p>');
});

// API route that calls backend
app.get('/api', async (req, res) => {
  try {
    // Call backend service (in Kubernetes this will be the Service name)
    const backendUrl = process.env.BACKEND_URL || 'http://backend-service:4000/api';
    const response = await axios.get(backendUrl);

    res.send(`
      <h1>Frontend → Backend → Database</h1>
      <p>${JSON.stringify(response.data)}</p>
    `);
  } catch (err) {
    res.status(500).send('Error calling backend: ' + err.message);
  }
});

app.listen(PORT, () => {
  console.log(`Frontend running on port ${PORT}`);
});
