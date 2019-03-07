#displays banners whenever you enter a new round
def round_banners(index)
t1 = Artii::Base.new :font => 'big'
t2 = Artii::Base.new :font => 'doom'
  if index == 0
    puts t1.asciify("                       Round 1")
    sleep(1)
    puts "Each question if fur 5 bear-bucks!".center($GAME_WIDTH)
    gets.chomp
    system "clear"
  elsif index == 5
    puts t1.asciify("                       Round 2")
    sleep(1)
    puts "Each question if fur 10 bear-bucks!".center($GAME_WIDTH)
    gets.chomp
    system "clear"
  elsif index == 8
    puts t1.asciify("                       Round 3")
    sleep(1)
    puts "Each question if fur 20 bear-bucks!".center($GAME_WIDTH)
    gets.chomp
    system "clear"
  end
end
