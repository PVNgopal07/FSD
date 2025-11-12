const express = require('express');
const session = require('express-session');
const app = express();
const PORT = 3000;

app.use(session({
  secret: 'mySecretKey123!',
  resave: false,
  saveUninitialized: false,
  cookie: { 
    maxAge: 60000
  }
}));

app.get('/', (req, res) => {
  if (req.session.views) {
    req.session.views++;
    res.send(`
      <h2>Welcome back!</h2>
      <p>You have visited this page <strong>${req.session.views}</strong> times.</p>
    `);
  } else {
    req.session.views = 1;
    res.send(`
      <h2>Hello! This is your first visit.</h2>
      <p>Refresh the page to increase the counter.</p>
    `);
  }
});

app.listen(PORT, () => {
  console.log(` Server running at http://localhost:${PORT}`);
});
