json.extract! sale_item, :id, :sale_id, :product_id, :quantity, :unit_price, :created_at, :updated_at
json.url sale_item_url(sale_item, format: :json)
