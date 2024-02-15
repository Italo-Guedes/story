json.extract! supplier, :id, :name, :address, :phone, :email, :cpf_cnpj, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)
