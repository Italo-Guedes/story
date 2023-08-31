# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id           :bigint           not null, primary key
#  image_url    :string
#  link_url     :string
#  subject_type :string
#  text         :string
#  viewed       :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  subject_id   :bigint
#  user_id      :bigint
#

# Notification class, to use with internal notification system
# Notification.create(
#   user: User.first,
#   subject: Model,
#   text: "Texto",
#   link_url: "/admin/users",
#   image_url: "/img/profile-menu.png"
# )
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true
  after_commit :send_notification, on: :create

  validates :text, :user_id, presence: true

  def send_notification
    # Any push notification should be sent here, but with the help of a background job

    # ActionCable.server.broadcast(
    #   "user_#{user_id}_channel",
    #   number: user.unviewed_notifications.count,
    #   html: render_notification(self)
    # )
  end

  def best_url
    link_url.presence || subject
  end

  def best_image
    if subject.present? && subject.respond_to?(:best_image)
      subject.best_image
    else
      image_url
    end
  end

  private

  def render_notification(notification)
    NotificationsController.render partial: 'notifications/notification', locals: { notification: }
  end
end
