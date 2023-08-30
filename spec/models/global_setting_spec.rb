# frozen_string_literal: true

# == Schema Information
#
# Table name: global_settings
#
#  id                :bigint           not null, primary key
#  menu_border_color :string           default("#FFFFFF")
#  menu_color        :string           default("#D12E5E")
#  page_author       :string           default("Rdmapps")
#  page_description  :string           default("Startkit rdmapps")
#  page_subtitle     :string           default("startkit")
#  page_title        :string           default("Rdmapps")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe GlobalSetting, type: :model do
  it 'Must exist' do
    expect(described_class.instance).not_to be_blank
  end
end
