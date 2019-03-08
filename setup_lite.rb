# Conditionally install gems without external dependencies
# And then set up database
puts "Installing gem dependencies..."
system(`echo bundle install --without imagemagick`)
puts "...Done"
system(`echo rake setup_db`)
