TriviaApi.get_questions(amount: "50", category: 9, difficulty: "easy").shuffle.each do |question|
  Question.create(question)
end
TriviaApi.get_questions(amount: "50", category: 18, difficulty: "easy").shuffle.each do |question|
  Question.create(question)
end
TriviaApi.get_questions(amount: "50", category: 16, difficulty: "easy").shuffle.each do |question|
  Question.create(question)
end
TriviaApi.get_questions(amount: "50", category: 23, difficulty: "easy").shuffle.each do |question|
  Question.create(question)
end
TriviaApi.get_questions(amount: "50", category: 27, difficulty: "easy").shuffle.each do |question|
  Question.create(question)
end

TriviaApi.get_questions(amount: "50", category: 9, difficulty: "medium").shuffle.each do |question|
  Question.create(question)
end
TriviaApi.get_questions(amount: "50", category: 10, difficulty: "medium").shuffle.each do |question|
  Question.create(question)
end
TriviaApi.get_questions(amount: "50", category: 22, difficulty: "medium").shuffle.each do |question|
  Question.create(question)
end

TriviaApi.get_questions(amount: "45", category: 9, difficulty: "hard").shuffle.each do |question|
  Question.create(question)
end
TriviaApi.get_questions(amount: "40", category: 17, difficulty: "hard").shuffle.each do |question|
  Question.create(question)
end
TriviaApi.get_questions(amount: "15", category: 22, difficulty: "hard").shuffle.each do |question|
  Question.create(question)
end


User.create(name: "Brian")
User.create(name: "Jen")
User.create(name: "Cody")
User.create(name: "Alex Trebear")
GameSession.create(user_id: 1, total_score: 10)
GameSession.create(user_id: 4, total_score: 100)
GameSession.create(user_id: 1, total_score: 15)
GameSession.create(user_id: 2, total_score: 25)
GameSession.create(user_id: 2, total_score: 50)
GameSession.create(user_id: 2, total_score: 60)
GameSession.create(user_id: 3, total_score: 20)
GameSession.create(user_id: 1, total_score: 5)
GameSession.create(user_id: 2, total_score: 30)
