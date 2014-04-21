angular.module('testApp').factory "User", ['$q', ($q) ->
  User = {}

  # Just some default seed users to work with for local testing
  User.default_users = [
    {username: 'test@test.com', password: 'password'}
  ]

  # These would obviously be $http or $resource calls
  # example: return $http.post( API.LOGIN_URL, { username: username, password: password } );

  User.authenticate = (username, password) ->

  User.register = (username, password) ->
    deferred = $q.defer()
    # Fake a bad response from the server
    if User.user_exists(username)
      deferred.reject('Invalid username.')
      return deferred.promise
    User.default_users.push({username: username, password: password})
    deferred.resolve({id: '123ad124', username: username})
    return deferred.promise

  User.user_exists = (username) ->
    User.default_users.some((u) ->
      username == u.username
    )

  User
]