'use strict'

angular.module('testApp').controller 'HeaderController', ($scope, $rootScope, $location, User) ->
  $scope.sign_out = ->
    User.sign_out()
    $rootScope.$broadcast('USER_SIGNOUT')
