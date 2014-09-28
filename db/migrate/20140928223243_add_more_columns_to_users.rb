class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth, :json
    add_column :users, :avatar, :text
  end
end
