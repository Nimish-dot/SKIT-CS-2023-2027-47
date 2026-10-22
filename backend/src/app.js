const express = require('express');
const cors = require('cors');

const performanceRoutes = require('./routes/performanceRoutes');
const healthRoutes = require('./routes/healthRoutes');
const athleteRoutes = require('./routes/athleteRoutes');
const assessmentRoutes = require('./routes/assessmentRoutes');

const app = express();

app.use(cors());
app.use(express.json());

app.use('/api/performance', performanceRoutes);
app.use('/api', healthRoutes);
app.use('/api/athletes', athleteRoutes);
app.use('/api/assessments', assessmentRoutes);

app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to SportsAI Backend API',
  });
});

module.exports = app;
