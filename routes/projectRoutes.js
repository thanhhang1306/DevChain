const express = require('express');
const router = express.Router();
const { postProject } = require('../controllers/projectController');

router.post('/', postProject);

module.exports = router;
