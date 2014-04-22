'use strict'

# Session controller to 'wrap' the entire app in.
# Just a simple way to manage state depending on user authentication.
angular.module('testApp').controller 'SessionController', ($scope, $rootScope, $location, User, Question) ->
  # Routes that don't need a valid user signed in
  $scope.safe_routes = ['/signin', '/register']
  $scope.handle_session = ->
    $scope.current_user = User.current_user
    # Just a simple function that we can build on and can be hit by any $on calls we might make
    unless User.signed_in || $location.path() in $scope.safe_routes
      $location.path('/signin')

  $scope.start_new_quiz = ->
    Question.create_quiz().then ->
      $location.path('/quiz/1')


  $rootScope.$on 'USER_SIGNOUT', $scope.handle_session
  $rootScope.$on 'USER_SIGNIN', $scope.handle_session
  $rootScope.$on 'START_QUIZ', $scope.start_new_quiz
  $rootScope.$on "$locationChangeStart", $scope.handle_session

