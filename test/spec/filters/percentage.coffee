'use strict'

describe 'Filter: percentage', ->
  filter = {}


  # load the controller's module
  beforeEach module 'testApp'

  beforeEach inject ($filter) ->
    filter = $filter('percentage')

  it 'has a percentage filter', ->
    expect(filter).not.toBeNull

  it 'should return a good string representation from a float', ->
    expect(filter(0.5)).toBe '50%'

  it 'should return a good string representation from an int', ->
    expect(filter(2)).toBe '200%'

  it 'should return a blank string from a non number', ->
    expect(filter('three')).toBe ''
