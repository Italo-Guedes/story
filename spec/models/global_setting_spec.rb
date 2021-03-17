# == Schema Information
#
# Table name: global_settings
#
#  id                :bigint(8)        not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  page_title        :string
#  page_author       :string
#  page_description  :string
#  menu_color        :string
#  menu_border_color :string
#

require 'rails_helper'

RSpec.describe GlobalSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
