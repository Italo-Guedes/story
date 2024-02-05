# frozen_string_literal: true

# Create global settings table, from Italo Ecommerce
class CreateGlobalSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :global_settings do |t|
      t.string  :page_title, default: 'Italo'
      t.string  :page_subtitle, default: 'ecommerce'
      t.string  :page_author, default: 'Italo'
      t.string  :page_description, default: 'ecommerce italo'
      t.string  :menu_color, default: '#D12E5E'
      t.string  :menu_border_color, default: '#FFFFFF'
      t.timestamps
    end
  end
end
