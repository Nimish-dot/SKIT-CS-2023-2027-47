const mongoose = require("mongoose");

const assessmentSchema = new mongoose.Schema(
  {
    athleteId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Athlete",
      required: true
    },

    sport: {
      type: String,
      required: true
    },

    videoUrl: {
      type: String,
      default: ""
    },

    status: {
      type: String,
      enum: [
        "pending",
        "processing",
        "completed",
        "failed"
      ],
      default: "pending"
    },

    performanceScore: {
      type: Number,
      default: 0,
      min: 0,
      max: 100
    },

    feedback: {
      type: String,
      default: ""
    }
  },
  {
    timestamps: true
  }
);

module.exports = mongoose.model(
  "Assessment",
  assessmentSchema
);