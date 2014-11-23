class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.timestamp :joined_at

      t.timestamps
    end
  end
end
