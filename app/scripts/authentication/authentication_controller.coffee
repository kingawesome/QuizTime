'use strict'

angular.module('testApp').controller 'AuthenticationController', ($scope) ->
  $scope.signin = ->
    console.log('signing in!')

  $scope.register = ->
    console.log('registering!')
