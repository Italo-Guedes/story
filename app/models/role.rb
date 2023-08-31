# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime
#  updated_at    :datetime
#  resource_id   :integer
#

# Role class, helps with user authorization rules
class Role < ApplicationRecord
  # Disabling rubocop as this is a third party gem behaviour
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :users, join_table: :users_roles
  # rubocop:enable Rails/HasAndBelongsToMany
  belongs_to :resource, polymorphic: true, optional: true
  scopify

  def self.allowed_roles(current_user)
    roles = []
    if current_user.has_role? :admin
      roles = %w[admin operator]
    elsif current_user.has_role? :super_admin
      roles = %w[super_admin admin operator]
    end
    Role.where(name: roles).order(Arel.sql("name <> 'super_admin', name <> 'admin', name <> 'operator'"))
  end
end
