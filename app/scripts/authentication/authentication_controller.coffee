'use strict'

angular.module('testApp').controller 'AuthenticationController', ($scope, User) ->
  $scope.signin = ->
    console.log('signing in!')

  $scope.register = (username, password) ->
    User.register(username, password).then($scope.user_registered, $scope.user_not_registered)

  $scope.user_registered = (user) ->
    console.log(user)

  $scope.user_not_registered = (error) ->
    console.log(error)

  $scope.user_authenticated = (user) ->

  $scope.user_not_authenticated = (user) ->


