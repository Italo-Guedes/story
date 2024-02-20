# == Schema Information
#
# Table name: sale_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer
#  total      :decimal(, )
#  unit_price :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  sale_id    :bigint           not null
#
FactoryBot.define do
  factory :sale_item do
    sale { nil }
    product { nil }
    quantity { 1 }
    unit_price { "9.99" }
  end
end
