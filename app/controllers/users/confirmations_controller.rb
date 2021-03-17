class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_confirmation_path_for(resource_name, resource)
    if signed_in?(resource_name)
      signed_in_root_path(resource)
    else
      # Change this path if using react login
      # Maybe something like
      ### public_path if user.has_role?(:customer)
      # public_path(flash_notice: 'Conta confirmada com sucesso. Faça login para contiuar.')
      new_session_path(resource_name)
    end
  end
end