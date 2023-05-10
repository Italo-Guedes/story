# frozen_string_literal: true

# Creation of comments table, from rdmapps startkit
class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :commenteable_id
      t.string :commenteable_type
      t.references :user, index: true, foreign_key: true
      t.text :text

      t.timestamps null: false
    end
  end
end
