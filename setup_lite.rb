# Conditionally install gems without external dependencies
# And then set up database
puts "Installing gems..."
system(`echo bundle install --without imagemagick`)
puts "...Done"
system(`echo rake setup_db`)
