# == Schema Information
#
# Table name: notifications
#
#  id           :bigint           not null, primary key
#  image_url    :string
#  link_url     :string
#  subject_type :string
#  text         :string
#  viewed       :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  subject_id   :integer
#  user_id      :bigint
#

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
