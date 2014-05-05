'use strict';

var mongoose = require('mongoose'),
  User = mongoose.model('User');

/**
 * Get User
 */
exports.getUser = function(req, res) {
  return User.find(function (err, result) {
    if (!err) {
      console.log(result);
      return res.json(result);
    } else {
      return res.send(err);
    }
  });
};

exports.addUser = function(req, res) {
  var adminUser = new User({ email: 'godong9@gmail.com', name: 'Daniel Go', pw: '123456' });
  adminUser.save(function (err) {
    if (err) return handleError(err);
    return res.send("Success");
  })
};