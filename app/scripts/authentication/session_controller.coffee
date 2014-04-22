'use strict'

# Session controller to 'wrap' the entire app in.
# Just a simple way to manage state depending on user authentication.
angular.module('testApp').controller 'SessionController', ($scope, $rootScope, $location, User, Question) ->
  $scope.handle_session = ->
    $scope.current_user = User.current_user
    # Just a simple function that we can build on and can be hit by any $on calls we might make
    unless User.signed_in
      # Redirect to root, root should react to an unauthorized user appropriately
      $location.path('/')

  $scope.start_new_quiz = ->
    console.log('staritng new quiz')
    Question.create_quiz().then ->
      console.log('redirecting')
      $location.path('/quiz/1')


  $rootScope.$on('USER_SIGNOUT', $scope.handle_session)
  $rootScope.$on('USER_SIGNIN', $scope.handle_session)
  $rootScope.$on('START_QUIZ', $scope.start_new_quiz)

