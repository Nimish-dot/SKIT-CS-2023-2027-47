const mongoose = require("mongoose");
const Performance = require("../models/performanceModel");
const Assessment = require("../models/assessmentModel");

const createPerformance = async (req, res) => {
  try {
    const {
      assessmentId,
      speed,
      agility,
      accuracy,
      consistency,
      aiFeedback,
    } = req.body;

    if (
      !assessmentId ||
      speed === undefined ||
      agility === undefined ||
      accuracy === undefined ||
      consistency === undefined
    ) {
      return res.status(400).json({
        success: false,
        message: "Assessment ID and all four performance metrics are required",
      });
    }

    if (!mongoose.isValidObjectId(assessmentId)) {
      return res.status(400).json({
        success: false,
        message: "Invalid assessment ID",
      });
    }

    const assessment = await Assessment.findById(assessmentId);

    if (!assessment) {
      return res.status(404).json({
        success: false,
        message: "Assessment not found",
      });
    }

    const metrics = [speed, agility, accuracy, consistency];

    if (
      metrics.some(
        (value) =>
          typeof value !== "number" ||
          !Number.isFinite(value) ||
          value < 0 ||
          value > 100
      )
    ) {
      return res.status(400).json({
        success: false,
        message: "Performance metrics must be numbers between 0 and 100",
      });
    }

    const overallScore = Number(
      (metrics.reduce((sum, value) => sum + value, 0) / metrics.length).toFixed(2)
    );

    const performance = await Performance.create({
      assessmentId,
      speed,
      agility,
      accuracy,
      consistency,
      overallScore,
      aiFeedback: aiFeedback || "",
    });

    return res.status(201).json({
      success: true,
      message: "Performance saved successfully",
      performance,
    });
  } catch (error) {
    console.error("Create performance error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Failed to save performance",
    });
  }
};

const getPerformances = async (req, res) => {
  try {
    const performances = await Performance.find()
      .populate("assessmentId")
      .sort({ createdAt: -1 });

    return res.status(200).json({
      success: true,
      count: performances.length,
      performances,
    });
  } catch (error) {
    console.error("Get performances error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Failed to fetch performances",
    });
  }
};

module.exports = { createPerformance, getPerformances };