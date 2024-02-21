# == Schema Information
#
# Table name: sales
#
#  id         :bigint           not null, primary key
#  date       :datetime
#  total      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint
#  user_id    :bigint           not null
#
FactoryBot.define do
  factory :sale do
    date { "2024-02-14 20:13:20" }
    total { "9.99" }
    user { nil }
    client { nil }
  end
end
