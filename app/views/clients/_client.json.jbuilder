json.extract! client, :id, :name, :address, :phone, :email, :cpf_cnpj, :is_active, :created_at, :updated_at
json.url client_url(client, format: :json)
