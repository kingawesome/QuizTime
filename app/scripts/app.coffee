'use strict'

angular.module('testApp', ['ngResource', 'ngRoute'])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/signin',
        templateUrl: 'scripts/authentication/signin.html'
        controller: 'AuthenticationController'
      .when '/register',
        templateUrl: 'scripts/authentication/register.html'
        controller: 'AuthenticationController'
      .when '/quiz/:question_id?',
        templateUrl: 'scripts/quiz/quiz.html'
        controller: 'QuizController'
      .otherwise
        redirectTo: '/signin'

