'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

/**
 * Resume Schema
 */
var ResumeSchema = new Schema({
  username: { type: String, required: true, unique: true },
  profile: { type: String, required: true},
  skills: { type: String, required: true},
  experience: { type: String, required: true},
  history: { type: String, required: true},
  education: { type: String, required: true}
});

/**
 * Validations
 */

mongoose.model('Resume', ResumeSchema);
