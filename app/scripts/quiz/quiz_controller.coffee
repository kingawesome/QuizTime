'use strict'

angular.module('testApp').controller 'QuizController', ($scope, $location, $routeParams, Question) ->
  $scope.alpha = ['A', 'B', 'C', 'D', 'E', 'F', 'G']

  Question.set_current_question($routeParams.question_id - 1)
  $scope.current_question = Question.current_question()

  $scope.next_question = ->
    if Question.questions.current_question_index + 1 == Question.total_questions
      # go to score
      console.log('next question!')
    else
      console.log('/quiz/' + $scope.next_question_id())
      $location.path('/quiz/' + $scope.next_question_id())

  $scope.normalized_current_question_id = ->
    parseInt(Question.current_question_index) + 1

  $scope.next_question_id = ->
    $scope.normalized_current_question_id() + 1
