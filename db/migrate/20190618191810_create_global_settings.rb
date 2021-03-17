class CreateGlobalSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :global_settings do |t|
      t.integer :global_price

      t.timestamps
    end
  end
end
