angular.module('testApp').factory "Question", ['$http', ($http) ->
  Question = {}
  Question.questions = []
  Question.current_question_index = 0
  Question.total_questions = 0

  # Ideally this would be something that accepts a param or url so you could switch between multiple quizzes.
  # Works good for now as prototype
  Question.create_quiz = ->
    Question.load_questions('/raw_data/questions.json')

  Question.load_questions = (url) ->
    $http.get(url).then (response)->
      Question.build_quiz(response.data)

  Question.set_current_question = (id) ->
    Question.current_question_index = parseInt(id)
    Question.questions[Question.current_question_index]

  Question.build_quiz = (questions) ->
    Question.questions = questions
    for key, q of Question.questions
      q.user_selected = -1
    Question.current_question_index = 0
    Question.total_questions = questions.length

  Question.current_question = ->
    if Question.total_questions > 0 && Question.current_question_index >= 0 && Question.current_question_index <= (Question.total_questions - 1)
      Question.questions[Question.current_question_index]
    else
      false

  Question.correct_percentage = ->
    correct_answers = 0
    for key, q of Question.questions
      correct_answers += 1 if Question.user_answered_correctly(q)
    correct_answers / Question.total_questions

  Question.user_answered_correctly = (q) ->
    parseInt(q.user_selected) == parseInt(q.correct_answer)

  Question
]
