'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

/**
 * Resume Schema
 */
var ResumeSchema = new Schema({
  name: String,
  data: String
});

/**
 * Validations
 */


mongoose.model('Resume', ResumeSchema);
