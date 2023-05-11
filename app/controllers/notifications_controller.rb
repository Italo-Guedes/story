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
    @notifications.where(viewed: false).update_all viewed: true
    head :no_content
  end

  def mark_read
    @notification.update_attribute :viewed, true
    head :no_content
  end
end
