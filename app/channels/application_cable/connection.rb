# frozen_string_literal: true

module ApplicationCable
  # Unused action cable class
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      # NOTE: connection bypassed
      reject_unauthorized_connection

      # self.current_user = find_verified_user

      # logger.add_tags 'ActionCable', current_user.email
      # logger.add_tags 'ActionCable', current_user.id
    end

    protected

    # this checks whether a user is authenticated with devise
    def find_verified_user
      env['warden'].user || reject_unauthorized_connection
    end
  end
end
