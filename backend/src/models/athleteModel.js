const mongoose = require("mongoose");

const athleteSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true
    },

    email: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      lowercase: true
    },

    sport: {
      type: String,
      required: true,
      trim: true
    },

    location: {
      type: String,
      default: ""
    },

    age: {
      type: Number,
      min: 5,
      max: 100
    }
  },
  {
    timestamps: true
  }
);

module.exports = mongoose.model("Athlete", athleteSchema);