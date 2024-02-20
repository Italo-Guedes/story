class AddTotalToSaleItems < ActiveRecord::Migration[6.1]
  def change
    add_column :sale_items, :total, :decimal
  end
end
