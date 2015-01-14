class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.text :title
      t.text :description
      t.text :image_url
      t.datetime :submitted_at
      t.timestamps
      t.integer :wins, default: 0
      t.integer :losses, default: 0
      t.float :rank, default: 0.0
    end
     ## add_index :participations, [:user_id, :challenge_id], unique: true
  end
end
