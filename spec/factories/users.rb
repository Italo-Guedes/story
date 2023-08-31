# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  is_active              :boolean          default(TRUE)
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locale                 :string           default("pt-BR")
#  locked_at              :datetime
#  name                   :string
#  phone                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  timezone               :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime
#  updated_at             :datetime
#

FactoryBot.define do
  factory :user, aliases: [:user_admin_default] do
    avatar { Rack::Test::UploadedFile.new('spec/support/assets/test-image.png', 'image/png') }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'lklklklk' }
    password_confirmation { password }
    confirmed_at { 1.hour.ago }
    trait :super_admin do
      before(:create) { |user| user.roles << Role.find_or_create_by(name: :super_admin) }
    end
    factory :user_super_admin, traits: [:super_admin]
  end
end
