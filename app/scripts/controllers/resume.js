'use strict';

angular.module('myhomeApp')
  .controller('ResumeCtrl', function ($scope, $http, $compile) {
    $http.get('/api/resume').success(function(resumeData) {

      resumeData.profile = new String(resumeData.profile);
      resumeData.profile.replace(/\n/gi, '<br>');
      resumeData.skills = new String(resumeData.skills);
      resumeData.skills = resumeData.skills.replace(/\n/gi, '<br>');
      resumeData.experience = new String(resumeData.experience);
      resumeData.experience = resumeData.experience.replace(/\n/gi, '<br>');
      resumeData.history = new String(resumeData.history);
      resumeData.history = resumeData.history.replace(/\n/gi, '<br>');
      resumeData.education = new String(resumeData.education);
      resumeData.education = resumeData.education.replace(/\n/gi, '<br>');
      $scope.resumeData = resumeData;
    });
  });
