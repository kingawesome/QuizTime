'use strict'

describe 'Controller: Quiz', ->
  scope = {}
  root_scope = {}
  routeParams =
    question_id: 1
  Question =
    current_question_index: 0
    set_current_question: (id) ->
    current_question: ->
      {question: 'test question', answers: ['answer 1', 'answer 2'], correct_answer: 0}

  # load the controller's module
  beforeEach module 'testApp'

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    root_scope = $rootScope
    $controller 'QuizController', {
      $scope: scope,
      $rootScope: $rootScope
      Question: Question
      $routeParams: routeParams
    }

  it 'normalize_current_question_id should give a 1-index adjusted number for current question index', ->
    expect(scope.normalized_current_question_id()).toBe 1

  it 'next_question_id should return +1 to the current normalized question id', ->
    expected_id = scope.normalized_current_question_id() + 1
    expect(scope.next_question_id()).toBe expected_id

  it 'next_question should redirect to /quiz/:id', inject ($location) ->
    $location.path('/quiz/1')
    expect($location.path()).toBe('/quiz/1')
    scope.next_question()
    expect($location.path()).toBe('/quiz/2')

