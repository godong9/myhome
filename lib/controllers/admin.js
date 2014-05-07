'use strict';

var mongoose = require('mongoose'),
  User = mongoose.model('User');

var passport = require('passport')
  , LocalStrategy = require('passport-local').Strategy;

function registerSession(req, username) {
  req.session.username = username;
}

passport.use(new LocalStrategy(
  function(username, password, done) {
    User.findOne({ username: username }, function(err, user) {
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

/**
 * POST login
 */
exports.login = function(req, res) {
  passport.authenticate('local', function(err, user) {
    if (err) { return res.send(err); }
    if (!user) { return res.redirect('/login'); }
    registerSession(req, user.username);
    return res.redirect('/admin');
  })(req, res);
};

exports.getData = function(req, res) {
  if(!req.session.username || req.session.username !== "godong9"){
    console.log("Permission Denied");
    return res.redirect('/login');
  }
  var result = {state:true};
  return res.send(result);
};

exports.postData = function(req, res) {
  console.log(req.body);
  return res.send("Success");
};

exports.getUser = function(req, res) {
  return User.find(function (err, result) {
    if (!err) {
      return res.json(result);
    } else {
      return res.send(err);
    }
  });
};

exports.addUser = function(req, res) {
  var adminUser = new User({ username:'godong9', email: 'godong9@gmail.com', password: 'dmdtka'});
  adminUser.save(function (err) {
    if (err) return res.send(err);
    return res.send("Success");
  })
};

