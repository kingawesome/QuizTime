angular.module('testApp').factory "User", ['$q', '$rootScope', ($q, $rootScope) ->
  User = {}

  User.current_user = null
  User.signed_in = false

  # Just some default seed users to work with for local testing
  # Un-hashed passwords because just stubbed. needs to be replaced with an actual backend to call against
  User.default_users = [
    {username: 'test@test.com', password: 'password'}
  ]

  # These would obviously be $http or $resource calls and we would not be storing them in plaintext
  # example: return $http.post( API.LOGIN_URL, { username: username, password: prehashed_password } );

  User.authenticate = (username, password) ->
    deferred = $q.defer()
    for key, user of User.default_users
      if user.username == username && password == password
        User.current_user = {id: '123ad124', username: username}
        deferred.resolve(User.current_user)
        return deferred.promise
    deferred.reject('Username or password is invalid.')
    return deferred.promise

  User.sign_out = ->
    User.current_user = null
    User.signed_in = false
    return true

  User.register = (username, password) ->
    deferred = $q.defer()
    # Fake a bad response from the server
    if User.user_exists(username)
      deferred.reject('Invalid username or username already taken.')
      return deferred.promise

    User.current_user = {id: '123ad124', username: username}
    User.default_users.push({username: username, password: password})
    deferred.resolve(User.current_user)
    return deferred.promise

  User.user_exists = (username) ->
    User.default_users.some((u) ->
      username == u.username
    )

  User
]