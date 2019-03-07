#displays banners whenever you enter a new round
def round_banners(index)
t1 = Artii::Base.new :font => 'big'
t2 = Artii::Base.new :font => 'doom'
  if index == 0
    puts t1.asciify("                       Round 1 ")
    puts "EASY".center($GAME_WIDTH).colorize(:green)
    puts
    puts
    sleep(1)
    puts "Each question is fur 5 bear-bucks!".center($GAME_WIDTH)
    gets.chomp
    system "clear"
  elsif index == 5
    puts t1.asciify("                       Round 2 ")
    puts "MEDIUM".center($GAME_WIDTH).colorize(:yellow)
    puts
    puts
    sleep(1)
    puts "Each question is fur 10 bear-bucks!".center($GAME_WIDTH)
    gets.chomp
    system "clear"
  elsif index == 8
    puts t1.asciify("                       Round 3 ")
    puts "HARD".center($GAME_WIDTH).colorize(:red)
    puts
    puts
    sleep(1)
    puts "Each question is fur 20 bear-bucks!".center($GAME_WIDTH)
    gets.chomp
    system "clear"
  end
end
