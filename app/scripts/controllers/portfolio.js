'use strict';

angular.module('myhomeApp')
  .controller('PortfolioCtrl', function ($scope, $http) {
    $http.get('/api/awesomeThings').success(function(awesomeThings) {
      console.log(awesomeThings);
      $scope.awesomeThings = awesomeThings;
    });
  });
