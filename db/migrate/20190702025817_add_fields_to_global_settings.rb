class AddFieldsToGlobalSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :global_settings, :page_title, :string
    add_column :global_settings, :page_subtitle, :string
    add_column :global_settings, :page_author, :string
    add_column :global_settings, :page_description, :string
    add_column :global_settings, :menu_color, :string
    add_column :global_settings, :menu_border_color, :string
    remove_column :global_settings, :global_price, :integer
  end
end
