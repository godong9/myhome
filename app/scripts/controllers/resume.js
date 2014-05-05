'use strict';

angular.module('myhomeApp')
  .controller('ResumeCtrl', function ($scope, $http) {
    $http.get('/api/resume').success(function(resumeData) {
      console.log(resumeData);
      $scope.resumeData = resumeData;
    });
  });
