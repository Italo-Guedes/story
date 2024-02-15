class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :address, :string
    add_column :users, :cpf_cnpj, :string
  end
end
