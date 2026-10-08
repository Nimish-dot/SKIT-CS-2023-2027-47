const assessments = [];

const createAssessment = (req, res) => {
  const { athleteId, sport, videoUrl } = req.body;

  if (!athleteId || !sport) {
    return res.status(400).json({
      success: false,
      message: 'Athlete ID and sport are required',
    });
  }

  const assessment = {
    id: assessments.length + 1,
    athleteId,
    sport,
    videoUrl: videoUrl || '',
    status: 'pending',
    performanceScore: null,
    feedback: '',
  };

  assessments.push(assessment);

  return res.status(201).json({
    success: true,
    message: 'Assessment created successfully',
    assessment,
  });
};

const getAssessments = (req, res) => {
  return res.status(200).json({
    success: true,
    count: assessments.length,
    assessments,
  });
};

module.exports = {
  createAssessment,
  getAssessments,
};