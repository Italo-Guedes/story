json.extract! product, :id, :sku, :name, :description, :quantity, :category_id, :resale_price, :supplier_id, :cost, :created_at, :updated_at
json.url product_url(product, format: :json)
