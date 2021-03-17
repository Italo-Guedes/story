# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'GlobalSettings', type: :request do
  describe 'GET /global_settings' do
    it 'works! (now write some real specs)' do
      get global_settings_path
      expect(response).to have_http_status(302)

      sign_in create(:user, :super_admin)
      get global_settings_path
      expect(response).to have_http_status(200)
    end
  end
end
