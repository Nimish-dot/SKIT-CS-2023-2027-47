const Athlete = require("../../../database/models/athleteModel");

const registerAthlete = async (req, res) => {
  try {
    const { name, email, sport, location, age } = req.body;

    if (!name || !email || !sport) {
      return res.status(400).json({
        success: false,
        message: "Name, email and sport are required",
      });
    }

    const athlete = await Athlete.create({
      name,
      email,
      sport,
      location: location || "",
      age: age === undefined || age === "" ? undefined : Number(age),
    });

    return res.status(201).json({
      success: true,
      message: "Athlete registered successfully",
      athlete,
    });
  } catch (error) {
    if (error.code === 11000) {
      return res.status(409).json({
        success: false,
        message: "An athlete with this email already exists",
      });
    }

    if (error.name === "ValidationError" || error.name === "CastError") {
      return res.status(400).json({
        success: false,
        message: "Invalid athlete data",
      });
    }

    console.error("Register athlete error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Failed to register athlete",
    });
  }
};

const getAthletes = async (req, res) => {
  try {
    const athletes = await Athlete.find().sort({ createdAt: -1 });

    return res.status(200).json({
      success: true,
      count: athletes.length,
      athletes,
    });
  } catch (error) {
    console.error("Get athletes error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Failed to fetch athletes",
    });
  }
};

module.exports = {
  registerAthlete,
  getAthletes,
};