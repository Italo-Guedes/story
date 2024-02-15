# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  address    :text
#  cpf_cnpj   :string
#  email      :string
#  is_active  :boolean
#  name       :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :client do
    name { "MyString" }
    address { "MyText" }
    phone { "MyString" }
    email { "MyString" }
    cpf_cnpj { "MyString" }
    is_active { false }
  end
end
