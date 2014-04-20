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
      .otherwise
        redirectTo: '/signin'

