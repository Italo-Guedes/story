# frozen_string_literal: true

module Abilities
  # Permission class for admin
  class Admin
    include CanCan::Ability

    def initialize(user)
      cannot :manage, Notification
      can :read, User

      can %i[new create edit update destroy], User
      cannot %i[destroy], User, id: user.id
      cannot %i[edit update destroy], User, roles: { name: :super_admin }

      can %i[index edit update], GlobalSetting
    end
  end
end
