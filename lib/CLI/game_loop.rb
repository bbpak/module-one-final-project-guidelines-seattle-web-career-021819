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
  print "\e[8;1000;#{$GAME_WIDTH}t"
  system "clear"

  $MAX_QUESTIONS.times do |index|
    difficulty = "easy"
    if (5..7).include?(index)
      difficulty = "medium"
    elsif index > 7
      difficulty = "hard"
    end

    round_banners(index)

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

    puts "(Current bear-bucks: #{$game_session.current_total_score})"
    print "Enter your answer: "
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

# Print host and question
def print_question(question)
  puts WordWrap.ww question.question.center($GAME_WIDTH), 85
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

  print_question(question)
  print_answers(answers_hash)
  return answers_hash
end


# Compares user answer with one of the possible answers
def check_answer(question, answer_hash, user_input)
  #track points in game_session. store correctness?
  correctness = answer_hash[user_input.upcase] == question.correct
  system "clear"
  print_question(question)
  print_colorized_answers(answer_hash, user_input.upcase, question.correct)
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
    print correct_msg.sample.colorize(:green)
  else
    print wrong_msg.sample.colorize(:red)
  end

  UserGuess.create(
    question_id: question.id,
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
  ans = Terminal::Table.new do |t|
    t.add_row ["A. #{answers["A"]}", "B. #{answers["B"]}"]
    t.add_row ["C. #{answers["C"]}", "D. #{answers["D"]}"]
    t.style = {:all_separators => true, :width => $GAME_WIDTH}
  end
  puts ans
end

# Colors the correct answer in green and wrong guess in red
def print_colorized_answers(answers, guess, correct)
  colorized_ans = answers.map do |letter, curr_answer|
    #binding.pry
    if curr_answer == correct
      "#{letter}. #{curr_answer}".colorize(:green)
    elsif answers[guess] == curr_answer
      "#{letter}. #{curr_answer}".colorize(:red)
    else
      "#{letter}. #{curr_answer}"
    end
  end

  ans = Terminal::Table.new do |t|
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
  puts ans
end

# Prints message after user quits
def end_message
  puts "Thanks for playing!"
  print "You got #{$game_session.get_correct_questions.length} questions correct "
  print "with total earnings of #{$game_session.current_total_score} bear-bucks!!"
  sleep(3)
  puts
end
