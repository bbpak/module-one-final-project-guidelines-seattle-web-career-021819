class UserGuess < ActiveRecord::Base
  belongs_to :game_session
  belongs_to :question
end
