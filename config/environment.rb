require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'lib'

# Have to explicitly require this for some reason?
# Maybe because it is conditionally installed
begin
  Gem::Specification::find_by_name('catpix') # Check if lite mode by installed gems
rescue Gem::LoadError
else
  require 'catpix'
end
