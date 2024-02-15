json.extract! sale, :id, :date, :total, :user_id, :client_id, :created_at, :updated_at
json.url sale_url(sale, format: :json)
