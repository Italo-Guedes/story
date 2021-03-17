class UserNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{current_user.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
  	puts data
    # process data sent from the page
  end
end