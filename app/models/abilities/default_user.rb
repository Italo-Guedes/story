# frozen_string_literal: true

module Abilities
  # Permission class for super admin role
  class DefaultUser
    include CanCan::Ability

    def initialize(user)
      can %i[index mark_read mark_all_read], Notification, user_id: user.id
    end
  end
end
