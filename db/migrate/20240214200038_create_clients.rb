class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :email
      t.string :cpf_cnpj
      t.boolean :is_active

      t.timestamps
    end
  end
end
