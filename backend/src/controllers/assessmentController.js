const mongoose = require("mongoose");
const Assessment = require("../models/assessmentModel");
const Athlete = require("../models/athleteModel");

const createAssessment = async (req, res) => {
  try {
    const { athleteId, sport, videoUrl } = req.body;

    if (!athleteId || !sport) {
      return res.status(400).json({
        success: false,
        message: "Athlete ID and sport are required",
      });
    }

    if (!mongoose.isValidObjectId(athleteId)) {
      return res.status(400).json({
        success: false,
        message: "Invalid athlete ID",
      });
    }

    const athlete = await Athlete.findById(athleteId);

    if (!athlete) {
      return res.status(404).json({
        success: false,
        message: "Athlete not found",
      });
    }

    const assessment = await Assessment.create({
      athleteId,
      sport,
      videoUrl: videoUrl || "",
      status: "pending",
    });

    return res.status(201).json({
      success: true,
      message: "Assessment created successfully",
      assessment,
    });
  } catch (error) {
    console.error("Create assessment error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Failed to create assessment",
    });
  }
};

const getAssessments = async (req, res) => {
  try {
    const assessments = await Assessment.find()
      .populate("athleteId", "name email sport")
      .sort({ createdAt: -1 });

    return res.status(200).json({
      success: true,
      count: assessments.length,
      assessments,
    });
  } catch (error) {
    console.error("Get assessments error:", error.message);
    return res.status(500).json({
      success: false,
      message: "Failed to fetch assessments",
    });
  }
};

module.exports = {
  createAssessment,
  getAssessments,
};