$game_session = nil
$MAX_QUESTIONS = 10

# Main method for the game loop
def start_game(user)
  initiate_game(user)
  question_loop
  end_message
  menu(user)
end

# Clear tables that shouldn't persist
def clear_all
  GameSession.delete_all
  UserGuess.delete_all
  #Question.delete_all
end

# Reset per-playthrough tables and
# start new game session for user
def initiate_game(user)
  clear_all
  $game_session = GameSession.create(user_id: user.id, total_score: 0)
end

# Question loop that fetches questions with increasing difficulty
def question_loop
  print "\e[8;30;#{$GAME_WIDTH}t"
  system "clear"

  $MAX_QUESTIONS.times do |index|
    difficulty = "easy"
    if (5..7).include?(index)
      difficulty = "medium"
    elsif index > 7
      difficulty = "hard"
    end

    curr_question = Question.find do |question|
      question.difficulty == difficulty &&
      !question.used
    end

    # If we run out of unique questions, reset
    if !curr_question
      Question.select do |question|
        question.difficulty == difficulty
      end.each do |question|
        question.update(used: false)
      end

      curr_question = Question.find do |question|
        question.difficulty == difficulty &&
        !question.used
      end
    end

    answer_hash = shuffle_and_print_answers(curr_question)
    curr_question.update(used: true)
    puts

    puts "(#{curr_question.difficulty.capitalize}, $#{curr_question.score})"
    puts "Enter your answer:"
    # user_input = gets.chomp
    user_input = get_answer
    check_answer(curr_question, answer_hash, user_input)
    sleep(3) if !$TEST_MODE
    system "clear"
  end
end

# Gets user answer
def get_answer
  user_input = gets.chomp
  if user_input.empty?
    get_answer
  else
    user_input
  end
end

# Shuffles the possible answers and prints them
def shuffle_and_print_answers(question)
  answers = [
    question.correct,
    question.incorrect1,
    question.incorrect2,
    question.incorrect3
  ].shuffle

  answers_hash = {}
  letter = "A"
  answers.each do |answer|
    answers_hash[letter] = answer
    letter = letter.next
  end

  bear_eyes2
  puts
  puts
  puts question.question.center($GAME_WIDTH)
  puts
  puts print_answers(answers_hash)
  return answers_hash
end


# Compares user answer with one of the possible answers
def check_answer(quest, answer_hash, user_input)
  #track points in game_session. store correctness?
  correctness = answer_hash[user_input.upcase] == quest.correct
  system "clear"
  puts quest.question.center($GAME_WIDTH)
  puts
  puts print_colorized_answers(answer_hash, user_input.upcase, quest.correct)
  puts

  correct_msg = [
    "Pawesome!",
    "Beary good!",
    "More money for your honey!"
  ]
  wrong_msg = [
    "Bearly missed it.",
    "I hate to be the bearer of bad news...",
    "Not this time, Goldilocks.",
    "You can still claw your way back."
  ]

  if correctness
    puts correct_msg.sample.colorize(:green)
    puts
  else
    puts wrong_msg.sample.colorize(:red)
    puts
  end

  UserGuess.create(
    question_id: quest.id,
    game_session_id: $game_session.id,
    correctness: correctness
  )
end

# Clears the console and print answers
def show_answer()
  system "clear"
  print_answers
end


def print_answers(answers)
  Terminal::Table.new do |t|
    t.add_row ["A. #{answers["A"]}", "B. #{answers["B"]}"]
    t.add_row ["C. #{answers["C"]}", "D. #{answers["D"]}"]
    t.style = {:all_separators => true, :width => $GAME_WIDTH}
  end
end

# Colors the correct answer in green and wrong guess in red
def print_colorized_answers(answers, guess, correct)
  colorized_ans = answers.map do |letter, answer|
    if answer == answers[guess]
      "#{letter}. #{answer}".colorize(:green)
    elsif answer == correct
      "#{letter}. #{answer}".colorize(:red)
    else
      "#{letter}. #{answer}"
    end
  end

  Terminal::Table.new do |t|
    t.add_row [
      colorized_ans[0],
      colorized_ans[1]
    ]
    t.add_row [
      colorized_ans[2],
      colorized_ans[3]
    ]
    t.style = {:all_separators => true, :width => $GAME_WIDTH}
  end
end
# Prints message after user quits
def end_message
  puts "Thanks for playing!"
  print "You got #{$game_session.get_correct_questions.length} questions correct "
  print "with total earnings of $#{$game_session.total_score}!!"
  sleep(3)
  puts
end
