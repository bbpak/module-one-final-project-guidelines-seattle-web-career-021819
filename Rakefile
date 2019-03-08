require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'install dependencies and setup db'
task :setup do
  Rake::Task["install"].invoke
  Rake::Task["setup_db"].invoke
end

desc 'installs all dependencies'
task :install do
  puts "Installing external dependencies..."
  puts "Installing imagemagick..."
  system(`echo brew install imagemagick@6`)
  puts "...Done"
  puts
  puts "Linking imagemagick..."
  system(`echo link --force imagemagick@6`)
  puts
  puts "Installing gem dependencies..."
  system(`echo bundle install`)
  puts "...Done"
  puts
end

desc 'creates and seeds db'
task :setup_db do
  puts "Initializing database..."
  puts "Creating tables..."
  Rake::Task["db:migrate"].invoke
  puts
  puts "Seeding tables..."
  Rake::Task["db:seed"].invoke
  puts "...Done"
  puts
end

desc 'run the program'
task :run do
  puts "Running \"WHO WANTS TO BE A MILLIONBEAR\"..."
  ruby "bin/run.rb"
end

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end
