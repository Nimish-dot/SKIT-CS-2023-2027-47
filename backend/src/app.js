
const express = require('express');
const cors = require('cors');

const errorHandler = require('./middleware/errorHandler');

const performanceRoutes = require('./routes/performanceRoutes');
const healthRoutes = require('./routes/healthRoutes');
const athleteRoutes = require('./routes/athleteRoutes');
const assessmentRoutes = require('./routes/assessmentRoutes');

const app = express();

// Global middleware
app.use(cors());
app.use(express.json());

// API routes
app.use('/api/performance', performanceRoutes);
app.use('/api', healthRoutes);
app.use('/api/athletes', athleteRoutes);
app.use('/api/assessments', assessmentRoutes);

// Root route
app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to SportsAI Backend API',
  });
});

// Handle unknown routes
app.use((req, res, next) => {
  const error = new Error('Route not found');
  error.statusCode = 404;
  next(error);
});

// Centralized error handler — must be last
app.use(errorHandler);

module.exports = app;
