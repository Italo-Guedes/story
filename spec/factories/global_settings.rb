# == Schema Information
#
# Table name: global_settings
#
#  id                :bigint           not null, primary key
#  #D12E5E           :string
#  #FFFFFF           :string
#  Rdmapps           :string
#  Startkit rdmapps  :string
#  menu_border_color :string
#  menu_color        :string
#  page_author       :string
#  page_description  :string
#  page_subtitle     :string
#  page_title        :string           default("Rdmapps")
#  startkit          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryBot.define do
  factory :global_setting do
  end
end
