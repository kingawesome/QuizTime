'use strict'

angular.module('testApp').controller 'AuthenticationController', ($scope, $rootScope, $timeout, User) ->
  #TODO: Replace with actual pub/sub notication system with directive to display
  $scope.notification =
    display: false
    type: null # null, 'alert-danger', 'alert-success'
    message: null
    show: (type, message)->
      this.type = type
      this.message = message
      this.display = true
    hide: ->
      this.display = false

  $scope.sign_in = (username, password) ->
    console.log('signing in')
    User.authenticate(username, password).then($scope.user_authenticated, $scope.user_not_authenticated)

  $scope.register = (username, password) ->
    User.register(username, password).then($scope.user_registered, $scope.user_not_registered)

  $scope.user_registered = (user) ->
    $scope.notification.show('alert-success', 'Account successfully created.')
    $rootScope.$broadcast('USER_SIGNIN')

  $scope.user_not_registered = (error) ->
    $scope.notification.show('alert-danger', error)

  $scope.user_authenticated = (user) ->
    $rootScope.$broadcast('USER_SIGNIN')

  $scope.user_not_authenticated = (error) ->
    $scope.notification.show('alert-danger', error)


