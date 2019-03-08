class GameSession < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :user_guesses

  def get_correct_questions
    UserGuess.all.select {|guess| guess.correctness}
  end

  def current_total_score
    total = self.get_correct_questions.inject(0){|sum, guess| sum+guess.question.score}
    self.update(total_score: total)
    total
  end

  def guess_record
    UserGuess.all.map {|guess| guess.correctness}
  end
end
