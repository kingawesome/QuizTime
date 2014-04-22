angular.module('testApp').factory "Question", ['$http', ($http) ->
  Question = {}
  Question.questions = []
  Question.current_question_index = 0
  Question.total_questions = 0

  # Ideally this would be something that accepts a param or url so you could switch between multiple quizes.
  # Works good for now as prototype
  Question.create_quiz = ->
    Question.load_questions('/raw_data/questions.json')

  Question.load_questions = (url) ->
    $http.get(url).then (response)->
      Question.build_quiz(response.data)

  Question.set_current_question = (id) ->
    Question.current_question_index = id
    Question.questions[id]

  Question.build_quiz = (questions) ->
    Question.questions = questions
    Question.current_question_index = 0
    Question.total_questions = questions.length

  Question.current_question = ->
    if Question.total_questions > 0 && Question.current_question_index >= 0 && Question.current_question_index <= (Question.total_questions - 1)
      Question.questions[Question.current_question_index]
    else
      false


  Question
]
