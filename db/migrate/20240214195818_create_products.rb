class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.text :description
      t.integer :quantity
      t.references :category, null: false, foreign_key: true
      t.decimal :resale_price
      t.references :supplier, null: false, foreign_key: true
      t.decimal :cost

      t.timestamps
    end
  end
end
