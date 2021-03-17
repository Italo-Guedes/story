class ChangeNotificationToBePolymorphic < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :subject_id, :integer
    add_column :notifications, :subject_type, :string
    add_index :notifications, %i[subject_type subject_id]
    change_column :notifications, :viewed, :boolean, default: false
  end
end
