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
require 'rails_helper'

RSpec.describe Supplier, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
