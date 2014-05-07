'use strict';

angular.module('myhomeApp')
  .controller('AdminCtrl', function ($scope, $http, $location) {
    $http.get('/api/admin')
      .success(function(data) {
        $scope.adminData = data;
      })
      .error(function(err) {
        console.log(err);
        $location.path('/login');
      });
  });
