'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

/**
 * User Schema
 */
var UserSchema = new Schema({
  email: String,
  name: String,
  pw: String
});

/**
 * Validations
 */


mongoose.model('User', UserSchema);
