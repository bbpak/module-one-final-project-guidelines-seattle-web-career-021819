$MAX_QUESTIONS = 10

# Main method for the game loop
def start_game(user)
  $game_session = nil
  UserGuess.delete_all

  initiate_game(user)
  question_loop
  end_message
  menu(user)
end

# Reset per-playthrough tables and
# start new game session for user
def initiate_game(user)
  $game_session = GameSession.create(
    user_id: user.id,
    total_score: 0,
    fifty_fifty: 1,
    phone_a_friend: 1
  )
end

def get_questions_for_game
  questions = []

  $MAX_QUESTIONS.times do |index|
    difficulty = "easy"
    if (5..7).include?(index)
      difficulty = "medium"
    elsif index > 7
      difficulty = "hard"
    end

    question = Question.find do |curr_question|
      curr_question.difficulty == difficulty &&
      !curr_question.used
    end

    # If we run out of unique questions, reset
    if !question
      Question.select do |diff_quest|
        diff_quest.difficulty == diff_quest
      end.each do |used_quest|
        used_quest.update(used: false)
      end

      question = Question.find do |curr_question|
        curr_question.difficulty == difficulty &&
        !curr_question.used
      end
    end

    questions << question
    question.update(used: true)
  end

  questions
end

# Question loop that fetches questions with increasing difficulty
def question_loop
  print "\e[8;1000;#{$GAME_WIDTH}t"
  system "clear"

  get_questions_for_game.each_with_index do |curr_question, index|
    round_banners(index)

    answer_hash = shuffle_and_print_answers(curr_question)
    ask_for_answer(curr_question, answer_hash, curr_question.correct)
  end
end

# Prints asking for user's answer and asks for input
# And then checks the user answer for correctness
def ask_for_answer(curr_question, answer_hash, correct, colorized_ans = nil)
  fifty = $game_session.fifty_fifty == 0 ? "#{$game_session.fifty_fifty}".colorize(:red) : "#{$game_session.fifty_fifty}"
  phone = $game_session.phone_a_friend == 0 ? "#{$game_session.phone_a_friend}".colorize(:red) : "#{$game_session.phone_a_friend}"
  puts "              Current bear-bucks: #{$game_session.current_total_score}     50/50: #{fifty}     Phone-a-friend: #{phone}"
  puts
  print "Enter your answer: "
  # user_input = gets.chomp
  user_input = get_answer

  # Check for use of gameshow helpers
  if (user_input.downcase.start_with?("fifty") || user_input.start_with?("50"))
    if $game_session.fifty_fifty == 0
      no_helper_usage("fifty-fifty", curr_question, answer_hash, correct, colorized_ans)
    else
      colorized_ans = fifty_fifty(answer_hash, correct)
      print_question(curr_question)
      puts colorized_ans
      ask_for_answer(curr_question, answer_hash, correct, colorized_ans)
    end
  elsif (user_input.downcase.start_with?("phone"))
    if $game_session.phone_a_friend == 0
      no_helper_usage("phone-a-friend", curr_question, answer_hash, correct, colorized_ans)
    else
      phone_a_friend(curr_question, answer_hash, colorized_ans)
      ask_for_answer(curr_question, answer_hash, correct, colorized_ans)
    end
  # Else check answer for correctness
  else
    check_answer(curr_question, answer_hash, user_input)
    sleep(3) if !$TEST_MODE
    system "clear"
  end
end

def no_helper_usage(helper, curr_question, answer_hash, correct, colorized_ans)
  system "clear"
  puts "You've already used up your #{helper} hints.".center($GAME_WIDTH).colorize(:red)
  print_question(curr_question)
  if colorized_ans
    puts colorized_ans
  else
    print_answers(answer_hash)
  end
  ask_for_answer(curr_question, answer_hash, correct, colorized_ans)
end

# Gets user answer
def get_answer(question=nil, answer_hash=nil, correct=nil)
  user_input = gets.chomp
  if user_input.empty?
    get_answer
  else
    user_input
  end
end

# Print host and question
def print_question(question, bear_mode = nil)
  if !$IS_LITE_MODE
    if bear_mode != nil
      Catpix::print_image "lib/cli/img/bear#{bear_mode}.png",
        :center_x => true,
        :resolution => "low",
        :bg_fill => false
      puts
    else
      Catpix::print_image "lib/cli/img/bear#{(1..3).to_a.sample}.png",
        :center_x => true,
        :resolution => "low",
        :bg_fill => false
      puts
    end
  end
  puts WordWrap.ww question.question.center($GAME_WIDTH), $GAME_WIDTH
end

# Shuffles the possible answers and prints them
def shuffle_and_print_answers(question)
  answers = [
    question.correct,
    question.incorrect1,
    question.incorrect2,
    question.incorrect3
  ].shuffle

  answer_hash = {}
  letter = "A"
  answers.each do |answer|
    answer_hash[letter] = answer
    letter = letter.next
  end

  print_question(question)
  print_answers(answer_hash)
  return answer_hash
end


# Compares user answer with one of the possible answers
def check_answer(question, answer_hash, user_input)
  #track points in game_session. store correctness?
  correctness = answer_hash[user_input.upcase] == question.correct || user_input.downcase == question.correct.downcase
  system "clear"
  bear_mode = correctness ? "5" : "4"
  print_question(question, bear_mode)
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
  puts "Thanks for playing!".center($GAME_WIDTH)
  puts
  print "You got #{$game_session.get_correct_questions.length} questions correct with total earnings of #{$game_session.current_total_score} bear-bucks!!".center($GAME_WIDTH)
  puts
  puts
  puts
  bear_paw
  sleep(1)
  gets.chomp
end
