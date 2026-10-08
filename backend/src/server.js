const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');

const healthRoutes = require('./routes/healthRoutes');
const athleteRoutes = require('./routes/athleteRoutes');
const assessmentRoutes = require('./routes/assessmentRoutes');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

app.use('/api', healthRoutes);
app.use('/api/athletes', athleteRoutes);
app.use('/api/assessments', assessmentRoutes);

app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to SportsAI Backend API',
  });
});

app.listen(PORT, () => {
  console.log("SportsAI backend running on port " + PORT);
});