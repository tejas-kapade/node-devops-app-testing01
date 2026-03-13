const express = require("express");
const mongoose = require("mongoose");

const app = express();

const PORT = process.env.PORT || 3000;
const MONGO_URL = process.env.MONGO_URL;

// MongoDB connection
mongoose.connect("mongodb://mongo:27017/devopsdb")
.then(() => console.log("MongoDB Connected"))
.catch(err => console.log(err));

app.get("/", (req, res) => {
  res.send(`
  <!DOCTYPE html>
  <html>
  <head>
      <title>DevOps Node App</title>
      <style>
          body{
              font-family: Arial, sans-serif;
              background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
              color: white;
              text-align: center;
              padding-top: 100px;
          }
          .container{
              background: rgba(0,0,0,0.4);
              padding:40px;
              border-radius:10px;
              width:400px;
              margin:auto;
              box-shadow:0 0 20px rgba(0,0,0,0.5);
          }
          h1{
              margin-bottom:10px;
          }
          p{
              color:#ddd;
          }
          a{
              display:inline-block;
              margin-top:20px;
              padding:10px 20px;
              background:#00c6ff;
              color:black;
              text-decoration:none;
              border-radius:5px;
              font-weight:bold;
          }
          a:hover{
              background:#00a2d3;
          }
      </style>
  </head>
  <body>
      <div class="container">
          <h1>🚀 DevOps Node.js Application</h1>
          <p>Application is running successfully inside Docker</p>
          <p>Connected to MongoDB Database</p>
          <a href="/health">Check Application Health</a>
      </div>
  </body>
  </html>
  `);
});

app.get("/health", (req, res) => {
  res.json({
    status: "running",
    uptime: process.uptime()
  });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});