'use strict';

angular.module('myhomeApp')
  .controller('ResumeCtrl', function ($scope, $http, $compile) {
    $http.get('/api/resume').success(function(resumeData) {
      console.log(resumeData);

      resumeData.profile = resumeData.profile.replace(/\n/gi, '<br>');
      resumeData.skills = resumeData.skills.replace(/\n/gi, '<br>');
      resumeData.experience = resumeData.experience.replace(/\n/gi, '<br>');
      resumeData.history = resumeData.history.replace(/\n/gi, '<br>');
      resumeData.education = resumeData.education.replace(/\n/gi, '<br>');
      $scope.resumeData = resumeData;
    });
  });
