const express = require('express');

const {
  registerAthlete,
  getAthletes,
} = require('../controllers/athleteController');

const router = express.Router();

router.post('/register', registerAthlete);
router.get('/', getAthletes);

module.exports = router;
