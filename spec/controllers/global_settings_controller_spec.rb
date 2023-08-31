# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GlobalSettingsController, type: :controller do
  login_super_admin

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: GlobalSetting.instance.to_param }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { page_title: 'new Title' }
      end

      it 'updates the requested global_setting' do
        global_setting = GlobalSetting.instance
        put :update, params: { id: global_setting.to_param, global_setting: new_attributes }
        global_setting.reload
        expect(global_setting.page_title).to eq(new_attributes[:page_title])
      end

      it 'redirects to the global_setting' do
        global_setting = GlobalSetting.instance
        put :update, params: { id: global_setting.to_param, global_setting: new_attributes }
        expect(response).to redirect_to(global_settings_path)
      end
    end
  end
end
