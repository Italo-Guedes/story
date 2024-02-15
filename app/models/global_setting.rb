# frozen_string_literal: true

# == Schema Information
#
# Table name: global_settings
#
#  id                :bigint           not null, primary key
#  menu_border_color :string           default("#FFFFFF")
#  menu_color        :string           default("#D12E5E")
#  page_author       :string           default("Italo")
#  page_description  :string           default("ecommerce italo")
#  page_subtitle     :string           default("ecommerce")
#  page_title        :string           default("Italo")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# Model class to store global config values, editable inside the system
class GlobalSetting < ApplicationRecord
  has_paper_trail

  # Campos fake para testes de campos.
  attr_accessor :cities, :currency, :field_date, :field_datetime

  def self.instance
    Rails.cache.fetch('global_setting_instance', expires_in: 1.minute) do
      GlobalSetting.first ||
        GlobalSetting.create!(
          page_title: 'Italo',
          page_subtitle: 'ecommerce',
          page_author: 'Italo',
          page_description: 'Um sistema feito pela Italo',
          menu_color: '#D12E5E',
          menu_border_color: '#FFFFFF'
        )
    end
  end
end
