# frozen_string_literal: true

# Unused channel class
class UserNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{current_user.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    Rails.logger.debug data
    # process data sent from the page
  end
end
