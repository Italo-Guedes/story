# frozen_string_literal: true

# == Schema Information
#
# Table name: global_settings
#
#  id                :bigint           not null, primary key
#  menu_border_color :string
#  menu_color        :string
#  page_author       :string
#  page_description  :string
#  page_subtitle     :string
#  page_title        :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# Model class to store global config values, editable inside the system
class GlobalSetting < ApplicationRecord
  has_paper_trail

  attr_accessor :cities, :currency, :field_date, :field_datetime

  @instance = GlobalSetting.first ||
              GlobalSetting.create!(
                page_title: 'Rdmapps',
                page_subtitle: 'startkit',
                page_author: 'Rdmapps',
                page_description: 'Um sistema feito pela Rdmapps',
                menu_color: '#D12E5E',
                menu_border_color: '#FFFFFF'
              )

  def self.instance
    @instance
  end
end
