# == Schema Information
#
# Table name: stocks
#
#  id         :bigint           not null, primary key
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
FactoryBot.define do
  factory :stock do
    quantity { 1 }
    product { nil }
  end
end
