def how_to_play(user)
  system "clear"
  puts "How to play:"
  puts
  puts "Select option 1 from the main menu to start a new game."
  puts
  puts "Enter A, B, C, or D to select the correct answer"
  puts
  puts "Unsure? Use a lifeline!"
  puts
  puts "50/50: Type in 50 to eliminate two of the wrong answers."
  puts
  puts "Phone A Friend: type in phone and then make a call to a friend for help."
  puts
  puts "That's it!"
  gets.chomp
  menu(user)
end
