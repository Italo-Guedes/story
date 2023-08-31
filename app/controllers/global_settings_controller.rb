# frozen_string_literal: true

# Controller for global settings
class GlobalSettingsController < ApplicationController
  before_action :load_global_setting
  load_and_authorize_resource

  # GET /global_settings
  # GET /global_settings.json
  def index; end

  # GET /global_settings/1/edit
  def edit; end

  # PATCH/PUT /global_settings/1
  # PATCH/PUT /global_settings/1.json
  def update
    respond_to do |format|
      if @global_setting.update(global_setting_params)
        format.html do
          redirect_to global_settings_url,
                      notice: "#{t('activerecord.models.global_setting.one')} atualizado com sucesso."
        end
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @global_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def global_setting_params
    params.require(:global_setting).permit(
      :page_title, :page_subtitle, :page_author, :page_description, :menu_color, :menu_border_color
    )
  end

  def load_global_setting
    @global_setting = GlobalSetting.instance
  end
end
