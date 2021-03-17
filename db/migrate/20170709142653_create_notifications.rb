class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.string :text
      t.string :image_url
      t.string :link_url
      t.boolean :viewed, default: false

      t.timestamps
    end
  end
end
