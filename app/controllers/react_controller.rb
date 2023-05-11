# frozen_string_literal: true

# react pages controller
class ReactController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'react'

  # Página para usuários não logados
  def public
    flash['notice'] = params[:flash_notice]
    flash['alert'] = params[:flash_alert]
    if current_user
      redirect_to site_path
    else
      render 'public.html.erb', layout: 'public_react'
    end
  end

  # Página de usuários logados
  def index
    flash['notice'] = params[:flash_notice]
    flash['alert'] = params[:flash_alert]
    redirect_to public_path unless current_user
  end
end
