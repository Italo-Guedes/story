# frozen_string_literal: true

# react page
class StaticsController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'static'

  # Página para usuários não logados
  def public
    flash['notice'] = params[:flash_notice]
    flash['alert'] = params[:flash_alert]
    if current_user
      redirect_to site_path
    else
      render 'public.html.erb', layout: 'public_static'
    end
  end

  # Página de usuários logados
  def index
    flash['notice'] = params[:flash_notice]
    flash['alert'] = params[:flash_alert]
    
    redirect_to public_path unless current_user
  end
end
