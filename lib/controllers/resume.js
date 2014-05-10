'use strict';

var mongoose = require('mongoose'),
  Resume = mongoose.model('Resume');

/**
 * Get Resume
 */
exports.getResume = function(req, res) {
  return Resume.findOne(function (err, result) {
    if (!err) {
      return res.json(result);
    } else {
      return res.send(err);
    }
  });
};