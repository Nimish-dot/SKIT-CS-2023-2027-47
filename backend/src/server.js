require("dotenv").config();
const connectDB = require("../config/db");
const express = require('express');
const cors = require('cors');
const performanceRoutes = require("./routes/performanceRoutes");

const healthRoutes = require('./routes/healthRoutes');
const athleteRoutes = require('./routes/athleteRoutes');
const assessmentRoutes = require('./routes/assessmentRoutes');



const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());
app.use("/api/performance", performanceRoutes);
app.use('/api', healthRoutes);
app.use('/api/athletes', athleteRoutes);
app.use('/api/assessments', assessmentRoutes);

app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to SportsAI Backend API',
  });
});

const startServer = async () => {
  try {
    await connectDB();

    app.listen(PORT, () => {
      console.log("SportsAI backend running on port " + PORT);
    });
  } catch (error) {
    console.error("Failed to start server:", error.message);
    process.exit(1);
  }
};

startServer();