class AddIsActiveToUsers < ActiveRecord::Migration[4.2]
  def up
    add_column :users, :is_active, :boolean, default: true
  end

  def down
    remove_column :users, :is_active, :boolean
  end
end
