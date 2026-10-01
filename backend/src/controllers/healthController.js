const healthCheck = (req, res) => {
  res.status(200).json({
    success: true,
    message: 'SportsAI backend is running',
    service: 'SportsAI Backend API'
  });
};

module.exports = {
  healthCheck
};