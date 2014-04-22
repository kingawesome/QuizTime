'use strict'

describe 'Controller: Authentication', ->
  # This feels wrong...
  scope = {}
  rootScope = {}
  test_user =
    username: 'test'
    password: 'test'
  mock_user = {}
  q = {}


  # load the controller's module
  beforeEach module 'testApp'

  beforeEach ->
    mock_user =
      authenticate: (user, pass) ->
        d = q.defer()
        if user == test_user.username && pass == test_user.password
          d.resolve({id: '123', username: test_user.username})
        else
          d.reject('Username or password is invaid')
        d.promise
      register: (user, pass) ->
        d = q.defer()
        if user == test_user.username
          d.reject('Username or password is invaid')
        else
          d.resolve({id: '123', username: test_user.username})
        d.promise

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, $q) ->
    scope = $rootScope.$new()
    rootScope = $rootScope
    q = $q
    $controller 'AuthenticationController', {
      $scope: scope,
      $rootScope: $rootScope,
      User: mock_user
    }

  it 'should broadcast USER_SIGNIN when "user_authenticated" method called', ->
    spyOn(rootScope, '$broadcast')
    scope.user_authenticated({foo: 'bar'})
    expect(rootScope.$broadcast).toHaveBeenCalledWith('USER_SIGNIN')


  describe 'With proper credentials', ->
    it 'should call "user_authenticated" when "sign_in" method is called', ->
      spyOn(scope, 'user_authenticated')
      scope.sign_in(test_user.username, test_user.password)
      scope.$apply()
      expect(scope.user_authenticated).toHaveBeenCalled

    it 'should call "user_registered" when "register" method is called', ->
      spyOn(scope, 'user_registered')
      scope.register('newuser@place.com', 'password')
      scope.$apply()
      expect(scope.user_registered).toHaveBeenCalled

  describe 'With bad credentials', ->
    it 'should call "user_not_authenticated" when "sign_in" method is called', ->
      spyOn(scope, 'user_not_authenticated')
      scope.sign_in('superbad@wrong.com', 'notcorrect')
      scope.$apply()
      expect(scope.user_not_authenticated).toHaveBeenCalled

    it 'should call "user_not_registered" when "register" method is called', ->
      spyOn(scope, 'user_not_registered')
      scope.register(test_user.username, test_user.password)
      scope.$apply()
      expect(scope.user_not_registered).toHaveBeenCalled
