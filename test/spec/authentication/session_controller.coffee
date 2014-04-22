'use strict'

describe 'Controller: Session', ->
  scope = {}
  root_scope = {}
  mock_user = {}

  # load the controller's module
  beforeEach module 'testApp'

  beforeEach ->
    mock_user =
      current_user: null
      signed_in: false


  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    root_scope = $rootScope
    $controller 'SessionController', {
      $scope: scope,
      $rootScope: $rootScope,
      User: mock_user
    }

  it 'should change location to "/" if user is signed out', inject( ($location) ->
    $location.path('/something')
    expect($location.path()).toBe('/something')
    scope.handle_session()
    expect($location.path()).toBe('/')
  )

  it 'should run "handle_session" method on receiving "USER_SIGNIN" broadcast', ->
    spyOn(scope, 'handle_session')
    root_scope.$broadcast('USER_SIGNIN')
    expect(scope.handle_session).toHaveBeenCalled

  it 'should run "handle_session" method on receiving "USER_SIGNOUT" broadcast', ->
    spyOn(scope, 'handle_session')
    root_scope.$broadcast('USER_SIGNOUT')
    expect(scope.handle_session).toHaveBeenCalled
