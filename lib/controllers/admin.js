'use strict';

var mongoose = require('mongoose'),
  User = mongoose.model('User'),
  Resume = mongoose.model('Resume');

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
    return res.status(401).send("Permission Denied");
  }
  var username = req.session.username;
  Resume.findOne({ username: username }, function (err, docs) {
    if (!err) {
      return res.json(docs);
    } else {
      return res.send(err);
    }
  });
};

exports.postData = function(req, res) {
  var resumeData = req.body;
  var username = req.session.username;
  if(!req.session.username || req.session.username !== "godong9"){
    console.log("Permission Denied");
    return res.redirect('/login');
  }
  Resume.update({ username: username },resumeData,function (err) {
    if (err) return res.send(err);
    return res.redirect('/');
  });
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
  });
};

