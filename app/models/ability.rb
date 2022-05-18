# frozen_string_literal: true

# Permission class
class Ability
  include CanCan::Ability
  def initialize(user)
    if user
      can :teste, :notification
      if user.has_cached_role?(:super_admin)
        can :manage, User
        cannot :destroy, User, id: user.id
        can :manage, GlobalSetting, id: GlobalSetting.instance.id
        can :read, :deleted_records
        can :admin_pages, :sidekiq
        can :admin_pages, :database_changes
        can :admin_pages, :pghero
      end

      if user.has_cached_role?(:admin) || user.has_cached_role?(:super_admin)
        merge Abilities::Admin.new(user)
      end

      can %i[index mark_read mark_all_read], Notification, user_id: user.id
    end

    cannot [:edit, :update, :destroy], :all do |model|
      model.respond_to?(:version) && model.version.present?
    end
  end
end