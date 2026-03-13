const express = require("express");
const mongoose = require("mongoose");

const app = express();

const PORT = 3000;

// MongoDB connection
mongoose.connect("mongodb://mongo:27017/devopsdb")
.then(() => console.log("MongoDB Connected"))
.catch(err => console.log(err));

app.get("/", (req, res) => {
  res.send("Hello from DevOps Node.js App 🚀");
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