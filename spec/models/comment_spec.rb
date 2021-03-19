# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  commenteable_type :string
#  text              :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  commenteable_id   :integer
#  user_id           :bigint
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
