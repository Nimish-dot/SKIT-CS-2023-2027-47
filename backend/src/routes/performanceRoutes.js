const express = require("express");

const {
  createPerformance,
  getPerformances,
} = require("../controllers/performanceController");

const router = express.Router();

router.post("/", createPerformance);
router.get("/", getPerformances);

module.exports = router;