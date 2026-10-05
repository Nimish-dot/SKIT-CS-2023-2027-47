const isValidScore = (value) => {
  return typeof value === 'number' && value >= 0 && value <= 100;
};

const validatePerformance = (performance) => {
  const requiredFields = [
    'assessmentId',
    'speed',
    'agility',
    'accuracy',
    'consistency',
  ];

  const missingFields = requiredFields.filter(
    (field) =>
      performance[field] === undefined ||
      performance[field] === null ||
      performance[field] === ''
  );

  if (missingFields.length > 0) {
    return {
      valid: false,
      errors: [`Missing fields: ${missingFields.join(', ')}`],
    };
  }

  const scoreFields = [
    'speed',
    'agility',
    'accuracy',
    'consistency',
  ];

  const invalidScores = scoreFields.filter(
    (field) => !isValidScore(performance[field])
  );

  if (invalidScores.length > 0) {
    return {
      valid: false,
      errors: [
        `Scores must be numbers between 0 and 100: ${invalidScores.join(', ')}`,
      ],
    };
  }

  return {
    valid: true,
    errors: [],
  };
};

module.exports = {
  validatePerformance,
};