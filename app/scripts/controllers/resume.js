'use strict';

angular.module('myhomeApp')
  .controller('ResumeCtrl', function ($scope, $http) {
    $http.get('/api/resume').success(function(resumeData) {
      //resumeData.profile = new String(resumeData.profile);
      var profile = new String(resumeData.profile);
      profile.replace(/\n/gi, '<br>');
      resumeData.profile = profile;

      var skills = new String(resumeData.skills);
      skills.replace(/\n/gi, '<br>');
      resumeData.skills = skills;

      var experience = new String(resumeData.experience);
      experience.replace(/\n/gi, '<br>');
      resumeData.experience = experience;

      var history = new String(resumeData.history);
      history.replace(/\n/gi, '<br>');
      resumeData.history = history;

      var education = new String(resumeData.education);
      education.replace(/\n/gi, '<br>');
      resumeData.education = education;

      $scope.resumeData = resumeData;
    });
  });
