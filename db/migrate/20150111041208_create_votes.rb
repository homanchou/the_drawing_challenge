class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.text :voting_history, array: true, default:[]
      t.timestamps null: false
    end
  end
end
