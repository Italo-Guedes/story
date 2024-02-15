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
#  brand_id     :bigint           not null
#  category_id  :bigint           not null
#  supplier_id  :bigint           not null
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
