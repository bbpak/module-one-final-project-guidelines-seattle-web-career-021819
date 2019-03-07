def phone_a_friend
  $game_session.update(phone_a_friend: $game_session.phone_a_friend-1)
end

def fifty_fifty(answers, correct)
  incorrect_ans = answers.select do |letter, answer|
    answer != correct
  end

  rand = incorrect_ans.values.sample(2)
  answers[answers.key(rand[0])] = rand[0].colorize(:black)
  answers[answers.key(rand[1])] = rand[1].colorize(:black)

  new_q = Terminal::Table.new do |t|
    t.add_row [
      "A. #{answers["A"]}",
      "B. #{answers["B"]}"
    ]
    t.add_row [
      "C. #{answers["C"]}",
      "D. #{answers["D"]}"
    ]
    t.style = {:all_separators => true, :width => $GAME_WIDTH}
  end

  $game_session.update(fifty_fifty: $game_session.fifty_fifty-1)
  new_q
end
