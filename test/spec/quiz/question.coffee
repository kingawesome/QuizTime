'use strict'

describe 'Factory: Question', ->
  sample_json = '[{"question": "what things?", "answers": ["foo", "bar", "baz"], "correct_answer": "1"}, {"question": "what other things?", "answers": ["oof", "rab", "zab"], "correct_answer": "2"}]'
  sample_url = 'testurl'
  httpBackend = {}
  service = {}

  # load the controller's module
  beforeEach module 'testApp'

  beforeEach inject (Question, $httpBackend) ->
    httpBackend = $httpBackend
    httpBackend.when('GET', sample_url).respond(sample_json)
    service = Question

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'after loading questions', ->
    it 'should have the correct number of questions', ->
      service.load_questions(sample_url)
      httpBackend.flush()
      expect(service.total_questions).toBe 2

    it 'should set the current question to index 0', ->
      service.load_questions(sample_url)
      httpBackend.flush()
      expect(service.current_question_index).toBe 0

    it 'current_question should return the proper question', ->
      service.load_questions(sample_url)
      httpBackend.flush()
      expect(service.current_question().question).toBe 'what things?'

    it 'set_current_question should change the question returned by current_question', ->
      service.load_questions(sample_url)
      httpBackend.flush()
      service.set_current_question(1)
      expect(service.current_question().question).toBe 'what other things?'

    describe 'after answering questions', ->
      it 'user_answered_correctly should return true if the user answered correctly', ->
        service.load_questions(sample_url)
        httpBackend.flush()
        q = service.questions[0]
        q.user_selected = 1
        expect(service.user_answered_correctly(q)).toBe true

      it 'user_answered_correctly should return false if the user answered incorrectly', ->
        service.load_questions(sample_url)
        httpBackend.flush()
        q = service.questions[0]
        q.user_selected = 2
        expect(service.user_answered_correctly(q)).toBe false

      it 'correct_percentage should return decimal representing correct/total questions answered', ->
        service.load_questions(sample_url)
        httpBackend.flush()
        service.questions[0].user_selected = 1
        service.questions[1].user_selected = 3
        expect(service.correct_percentage()).toBe 0.5

