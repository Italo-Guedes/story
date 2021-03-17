class AdminPagesController < ApplicationController
  # GET /background_jobs/sidekiq
  def sidekiq
    authorize! :admin_pages, :sidekiq
  end

  def database_changes
    authorize! :admin_pages, :database_changes
    params[:item_type] = 'todos' if params[:item_type].blank?
    # This is needed because in development, models are lazy loaded
    Rails.application.eager_load! if Rails.env.development?
    @models = ApplicationRecord.descendants - [Notification, Comment, Role]
    @versions = PaperTrail::Version.order(id: :desc).paginate(per_page: 20, page: params[:page].presence || 1)
    @versions = @versions.where(item_type: params[:item_type]) if params[:item_type] != 'todos'
  end

  def pghero
    authorize! :admin_pages, :pghero
  end
end
