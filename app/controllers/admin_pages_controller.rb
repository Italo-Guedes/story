# frozen_string_literal: true

# Controller for internal pages
class AdminPagesController < ApplicationController
  # GET /background_jobs/sidekiq
  def sidekiq
    authorize! :admin_pages, :sidekiq
  end

  def database_changes
    authorize! :admin_pages, :database_changes
    params[:item_type] = 'todos' if params[:item_type].blank?
    Rails.application.eager_load! if Rails.env.development?
    versions_load
  end

  def pghero
    authorize! :admin_pages, :pghero
  end

  private

  def versions_load
    # Excluding models with no papertrail needs
    @models = ApplicationRecord.descendants - [Notification, Comment, Role]
    @versions = PaperTrail::Version.order(id: :desc).paginate(per_page: 20, page: params[:page].presence || 1)
    # Filtering
    @versions = @versions.where(item_type: params[:item_type]) if params[:item_type] != 'todos'
  end
end
