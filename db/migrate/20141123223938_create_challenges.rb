class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.text :title
      t.datetime :start_at
      t.datetime :end_at
      t.text :description

      t.timestamps
    end
  end
end
