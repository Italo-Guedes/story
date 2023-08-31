# frozen_string_literal: true

# Notifications controller
class NotificationsController < ApplicationController
  load_and_authorize_resource

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = @notifications.where('id < ?', params[:notification_id]).order(id: :desc).limit(10)
    render layout: false
  end

  def mark_all_read
    # rubocop:disable Rails/SkipsModelValidations
    @notifications.where(viewed: false).update_all viewed: true
    # rubocop:enable Rails/SkipsModelValidations
    head :no_content
  end

  def mark_read
    @notification.update(viewed: true)
    head :no_content
  end
end
