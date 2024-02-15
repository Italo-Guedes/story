# == Schema Information
#
# Table name: suppliers
#
#  id         :bigint           not null, primary key
#  address    :text
#  cpf_cnpj   :string
#  email      :string
#  name       :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :supplier do
    name { "MyString" }
    address { "MyText" }
    phone { "MyString" }
    email { "MyString" }
    cpf_cnpj { "MyString" }
  end
end
