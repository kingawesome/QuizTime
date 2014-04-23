angular.module('testApp').filter 'percentage', ->
  (num) ->
    # not the most elegant, but works for a simple percentage display
    rounded = Math.round(num * 100)
    if isNaN(rounded)
      ''
    else
      rounded + '%'
