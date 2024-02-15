class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :email
      t.string :cpf_cnpj

      t.timestamps
    end
  end
end
