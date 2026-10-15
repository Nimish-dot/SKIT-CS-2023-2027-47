const mongoose = require('mongoose');

const performanceSchema = new mongoose.Schema(
  {
    assessmentId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Assessment',
      required: true,
    },

    speed: {
      type: Number,
      required: true,
      min: 0,
      max: 100,
    },

    agility: {
      type: Number,
      required: true,
      min: 0,
      max: 100,
    },

    accuracy: {
      type: Number,
      required: true,
      min: 0,
      max: 100,
    },

    consistency: {
      type: Number,
      required: true,
      min: 0,
      max: 100,
    },

    overallScore: {
      type: Number,
      min: 0,
      max: 100,
    },

    aiFeedback: {
      type: String,
      trim: true,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model('Performance', performanceSchema);