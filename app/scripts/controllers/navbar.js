'use strict';

angular.module('myhomeApp')
  .controller('NavbarCtrl', function ($scope, $location) {
    $scope.menu = [{
      'title': 'Home',
      'link': '/'
    }];
    
    $scope.isActive = function(route) {
      return (route === $location.path())?'active':'';
    };
  });
