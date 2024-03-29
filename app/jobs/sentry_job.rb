# frozen_string_literal: true

# Class to send sentry error messages in background
class SentryJob < ApplicationJob
  queue_as :default

  def perform(event)
    Raven.send_event(event)
  end
end
