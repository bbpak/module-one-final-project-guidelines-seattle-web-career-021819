# Install all dependencies for the project
# And then set up the database
puts "Installing external dependencies..."
puts "Installing imagemagick..."
system(`echo brew install imagemagick@6`)
puts "...Done"
puts
puts "Linking imagemagick..."
system(`echo link --force imagemagick@6`)
puts
# puts "Updating bundle..."
# system(`echo bundle update`)
puts "Installing gem dependencies..."
system(`echo bundle install --with imagemagick`)
puts "...Done"
puts
system(`echo rake setup_db`)
