'use strict';

var api = require('./controllers/api'),
    index = require('./controllers'),
    resume = require('./controllers/resume'),
    admin = require('./controllers/admin');
/**
 * Application routes
 */
module.exports = function(app) {

  app.route('/login')
    .post(admin.login);

  // Server API Routes
  app.route('/api/awesomeThings')
    .get(api.awesomeThings);

  app.route('/api/resume')
    .get(resume.getResume);

  app.route('/api/admin')
    .get(admin.getData)
    .post(admin.postData);

  app.route('/api/admin/getuser')
    .get(admin.getUser);

  app.route('/api/admin/adduser')
    .get(admin.addUser);

  // All undefined api routes should return a 404
  app.route('/api/*')
    .get(function(req, res) {
      res.send(404);
    });

  // All other routes to use Angular routing in app/scripts/app.js
  app.route('/partials/*')
    .get(index.partials);
  app.route('/*')
    .get(index.index);

};