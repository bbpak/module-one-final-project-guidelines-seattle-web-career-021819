(1..5).to_a.sample(5).each do |idx|
  case idx
  when 1
    TriviaApi.get_questions(amount: "50", category: 9, difficulty: "easy").shuffle.each do |question|
      Question.create(question)
    end
  when 2
    TriviaApi.get_questions(amount: "50", category: 18, difficulty: "easy").shuffle.each do |question|
      Question.create(question)
    end
  when 3
    TriviaApi.get_questions(amount: "50", category: 16, difficulty: "easy").shuffle.each do |question|
      Question.create(question)
    end
  when 4
    TriviaApi.get_questions(amount: "50", category: 23, difficulty: "easy").shuffle.each do |question|
      Question.create(question)
    end
  when 5
    TriviaApi.get_questions(amount: "50", category: 27, difficulty: "easy").shuffle.each do |question|
      Question.create(question)
    end
  else
    TriviaApi.get_questions(amount: "50", category: 9, difficulty: "easy").shuffle.each do |question|
      Question.create(question)
    end
  end
end

(1..3).to_a.sample(3).each do |idx|
  case idx
  when 1
    TriviaApi.get_questions(amount: "50", category: 9, difficulty: "medium").shuffle.each do |question|
      Question.create(question)
    end
  when 2
    TriviaApi.get_questions(amount: "50", category: 22, difficulty: "medium").shuffle.each do |question|
      Question.create(question)
    end
  when 3
    TriviaApi.get_questions(amount: "50", category: 10, difficulty: "medium").shuffle.each do |question|
      Question.create(question)
    end
  else
    TriviaApi.get_questions(amount: "50", category: 9, difficulty: "medium").shuffle.each do |question|
      Question.create(question)
    end
  end
end

(1..3).to_a.sample(3).each do |idx|
  case idx
  when 1
    TriviaApi.get_questions(amount: "45", category: 9, difficulty: "hard").shuffle.each do |question|
      Question.create(question)
    end
  when 2
    TriviaApi.get_questions(amount: "40", category: 17, difficulty: "hard").shuffle.each do |question|
      Question.create(question)
    end
  when 3
    TriviaApi.get_questions(amount: "15", category: 22, difficulty: "hard").shuffle.each do |question|
      Question.create(question)
    end
  end
end

b = User.find_or_create_by(name: "Beary White")
j = User.find_or_create_by(name: "Ursa Funny")
c = User.find_or_create_by(name: "Ted E. Bear")
bg = User.find_or_create_by(name: "Bear Grylls")
at = User.find_or_create_by(name: "Alex Trebear")
GameSession.find_or_create_by(user_id: c.id, total_score: 10)
GameSession.find_or_create_by(user_id: at.id, total_score: 100)
GameSession.find_or_create_by(user_id: b.id, total_score: 15)
GameSession.find_or_create_by(user_id: j.id, total_score: 25)
GameSession.find_or_create_by(user_id: j.id, total_score: 50)
GameSession.find_or_create_by(user_id: b.id, total_score: 60)
GameSession.find_or_create_by(user_id: c.id, total_score: 30)
GameSession.find_or_create_by(user_id: bg.id, total_score: 50)
