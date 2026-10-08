const athletes = [];

const registerAthlete = (req, res) => {
  const { name, email, sport, location, age } = req.body;

  if (!name || !email || !sport) {
    return res.status(400).json({
      success: false,
      message: 'Name, email and sport are required',
    });
  }

  const athlete = {
    id: athletes.length + 1,
    name,
    email,
    sport,
    location: location || '',
    age: age || null,
  };

  athletes.push(athlete);

  return res.status(201).json({
    success: true,
    message: 'Athlete registered successfully',
    athlete,
  });
};

const getAthletes = (req, res) => {
  return res.status(200).json({
    success: true,
    count: athletes.length,
    athletes,
  });
};

module.exports = {
  registerAthlete,
  getAthletes,
};