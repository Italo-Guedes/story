# frozen_string_literal: true

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

FactoryBot.define do
  factory :comment do
    text { Faker::Text.text }
    user
    commenteable { user }
  end
end
