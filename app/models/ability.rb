# frozen_string_literal: true

# Permission class
class Ability
  include CanCan::Ability
  def initialize(user)
    if user
      merge Abilities::DefaultUser.new(user)
      merge Abilities::Admin.new(user) if user.has_cached_role?(:admin)
      merge Abilities::SuperAdmin.new(user) if user.has_cached_role?(:super_admin)
    end

    cannot [:edit, :update, :destroy], :all do |model|
      model.respond_to?(:version) && model.version.present?
    end
  end
end
