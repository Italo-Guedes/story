# == Schema Information
#
# Table name: products
#
#  id           :bigint           not null, primary key
#  cost         :decimal(, )
#  description  :text
#  name         :string
#  quantity     :integer
#  resale_price :decimal(, )
#  sku          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint           not null
#  supplier_id  :bigint           not null
#
FactoryBot.define do
  factory :product do
    sku { "MyString" }
    name { "MyString" }
    description { "MyText" }
    quantity { 1 }
    category { nil }
    resale_price { "9.99" }
    supplier { nil }
    cost { "9.99" }
  end
end
