'use strict'

describe 'Controller: Header', ->
  scope = {}
  root_scope = {}
  mock_user = {}

  # load the controller's module
  beforeEach module 'testApp'

  beforeEach ->
    mock_user =
      sign_out: ->


  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    root_scope = $rootScope
    $controller 'HeaderController', {
      $scope: scope,
      $rootScope: $rootScope,
      User: mock_user
    }

