class CreateGameSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :game_sessions do |t|
      t.integer :user_id
      t.integer :total_score
      t.integer :fifty_fifty
      t.integer :phone_a_friend
    end
  end
end
