class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_locale, unless: :is_json
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  respond_to :html, :json

  around_action :user_time_zone, if: :current_user

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
  
  def configure_permitted_parameters
    # Don't allow avatar if it's empty
    if params[:user] && params[:user][:avatar].blank?
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    else
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :avatar) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :avatar) }
    end
  end

  def is_json
    request.format == :json
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, :alert => exception.message }
      format.json { render json: {error: :access_denied} }
    end
  end

  def set_locale
    I18n.locale = params[:locale] || current_user&.locale || I18n.default_locale
    current_user.update_attributes locale: I18n.locale.to_s if current_user && current_user.locale != I18n.locale.to_s
  end

  def default_url_options(options={})
    { :locale => (current_user && current_user.locale ? current_user.locale : false) || params[:locale] || I18n.default_locale }
  end

  def user_time_zone(&block)
    # se veio o parametro, vai ser ele, inclusive sobrescrevendo os settings do usuário.
    params_tz = params[:timezone] if params[:timezone].present?
    user_tz = current_user.timezone

    begin
      Time.zone = params_tz || user_tz
      current_user.update_attribute :timezone, params_tz if params_tz
    rescue => ex
      Raven.capture_message("Invalid timezone", this_is: "Timezone error. params: #{params_tz} user:#{user_tz}. ex: #{ex}") if Rails.env.production?
      params_tz = 'Brasilia'
    end    
    Time.use_zone((params_tz || user_tz), &block)
  end

  def attachment_names(klass)
    klass.reflect_on_all_attachments.filter do |association| 
      association.instance_of? ActiveStorage::Reflection::HasOneAttachedReflection
    end.map(&:name) rescue []
  end

  def sanitize_active_storage_params(klass, model)
    class_name = klass.name.underscore

    attachment_names(klass).each do |attachment_name|
      params[class_name].delete attachment_name if params.dig(class_name, attachment_name).blank?
      break unless params[class_name]["#{attachment_name}_remove"].to_i == 1

      params[class_name].delete attachment_name
      model&.send(attachment_name)&.purge
    end
  end
end
