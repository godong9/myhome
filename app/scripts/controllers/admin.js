'use strict';

angular.module('myhomeApp')
  .controller('AdminCtrl', function ($scope, $http, $location) {
    $http.get('/api/admin').success(function(data) {
      if(!data.state) {
        $location.path('/login');
      }
    });
  });
