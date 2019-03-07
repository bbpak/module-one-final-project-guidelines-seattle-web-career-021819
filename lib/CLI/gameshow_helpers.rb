def phone_a_friend(question, answers)
  $game_session.update(phone_a_friend: $game_session.phone_a_friend-1)
  system "clear"
  puts
  puts "Use this time to ask any one person for help.".center($GAME_WIDTH)
  puts "Then answer the question when you are ready.".center($GAME_WIDTH)
  puts

  print_question(question, "phone")
  print_answers(answers)
end

def fifty_fifty(answers, correct)
  $game_session.update(fifty_fifty: $game_session.fifty_fifty-1)
  system "clear"

  incorrect_ans = answers.select do |letter, answer|
    answer != correct
  end

  rand = incorrect_ans.values.sample(2)
  colorized_ans = answers.map do |letter, answer|
    if answers.key(rand[0]) == letter || answers.key(rand[1]) == letter
       "#{letter}. #{answer}".colorize(:black)
     else
       "#{letter}. #{answer}"
     end
  end

  new_q = Terminal::Table.new do |t|
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

  new_q
end
