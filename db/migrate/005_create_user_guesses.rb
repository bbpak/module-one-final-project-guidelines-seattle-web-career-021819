class CreateUserGuesses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_guesses do |t|
      t.integer :game_session_id
      t.integer :question_id
      t.boolean :correctness
    end
  end
end
