# frozen_string_literal: true

# Create global settings table, from rdmapps startkit
class CreateGlobalSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :global_settings do |t|
      t.string  :page_title, default: 'Rdmapps'
      t.string  :page_subtitle, default: 'startkit'
      t.string  :page_author, default: 'Rdmapps'
      t.string  :page_description, default: 'Startkit rdmapps'
      t.string  :menu_color, default: '#D12E5E'
      t.string  :menu_border_color, default: '#FFFFFF'
      t.timestamps
    end
  end
end
