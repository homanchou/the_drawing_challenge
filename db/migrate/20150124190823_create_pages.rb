class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :slug
      t.text :title
      t.text :body

      t.timestamps null: false
    end
  end
end
