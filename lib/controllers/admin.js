'use strict';

var mongoose = require('mongoose'),
  User = mongoose.model('User');

var passport = require('passport')
  , LocalStrategy = require('passport-local').Strategy;

/**
 * Get User
 */

exports.login = passport.authenticate('local', { successRedirect: '/',
    failureRedirect: '/login' });

passport.use(new LocalStrategy(
  function(username, password, done) {
    console.log(username);
    console.log(password);
    User.findOne({ username: username }, function(err, user) {
      console.log(user);
      if (err) { return done(err); }
      if (!user) {
        return done(null, false, { message: 'Incorrect username or password.' });
      }
      return done(null, user);
    });
  }
));

passport.serializeUser(function(user, done) {
  done(null, user.id);
});

passport.deserializeUser(function(id, done) {
  User.findById(id, function (err, user) {
    done(err, user);
  });
});

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
  var adminUser = new User({ username:'godong9', email: 'godong9@gmail.com', password: '123456'});
  adminUser.save(function (err) {
    if (err) return handleError(err);
    return res.send("Success");
  })
};

