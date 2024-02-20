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
require 'rails_helper'

RSpec.describe SaleItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
