'use strict'

angular.module('testApp').controller 'ScoreController', ($scope, Question) ->
  $scope.alpha = ['A', 'B', 'C', 'D', 'E', 'F', 'G']
  $scope.Question = Question
