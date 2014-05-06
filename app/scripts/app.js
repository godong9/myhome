'use strict';

angular.module('myhomeApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config(function ($routeProvider, $locationProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'partials/main',
        controller: 'MainCtrl'
      })
      .when('/portfolio', {
        templateUrl: 'partials/portfolio',
        controller: 'PortfolioCtrl'
      })
      .when('/resume', {
        templateUrl: 'partials/resume',
        controller: 'ResumeCtrl'
      })
      .when('/blog', {
        templateUrl: 'partials/blog',
        controller: 'BlogCtrl'
      })
      .when('/contact', {
        templateUrl: 'partials/contact',
        controller: 'ContactCtrl'
      })
      .when('/login', {
        templateUrl: 'partials/login'
      })
      .when('/admin', {
        templateUrl: 'partials/admin',
        controller: 'AdminCtrl'
      })
      .otherwise({
        redirectTo: '/'
      });
      
    $locationProvider.html5Mode(true);
  });