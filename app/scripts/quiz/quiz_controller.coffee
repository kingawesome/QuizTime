'use strict'

angular.module('testApp').controller 'QuizController', ($scope, $location, $routeParams, Question) ->
  $scope.alpha = ['A', 'B', 'C', 'D', 'E', 'F', 'G']

  Question.set_current_question($routeParams.question_id - 1)
  $scope.current_question = Question.current_question()
  unless $scope.current_question
    $location.path('/score')

  $scope.next_question = ->
      $location.path('/quiz/' + $scope.next_question_id())

  $scope.normalized_current_question_id = ->
    parseInt(Question.current_question_index) + 1

  $scope.next_question_id = ->
    $scope.normalized_current_question_id() + 1
