# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GlobalSettings', type: :request do
  describe 'GET /global_settings' do
    it 'is not accessible by a super admin' do
      sign_in FactoryBot.create(:user, :super_admin)
      get global_settings_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /global_settings/:id/edit' do
    it 'is accessible by a super admin' do
      sign_in FactoryBot.create(:user, :super_admin)
      get edit_global_setting_path(nil, GlobalSetting.instance.id)
      expect(response).to have_http_status(:ok)
    end
  end
end
