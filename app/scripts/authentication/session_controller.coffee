'use strict'

# Session controller to 'wrap' the entire app in.
# Just a simple way to manage state depending on user authentication.
angular.module('testApp').controller 'SessionController', ($scope) ->
