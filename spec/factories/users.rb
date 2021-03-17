# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string
#  phone                  :string
#  locale                 :string           default("pt-BR")
#  is_active              :boolean          default(TRUE)
#  timezone               :string
#

FactoryBot.define do
  factory :user, aliases: [:user_admin_default] do
    avatar { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png') }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'lklklklk' }
    password_confirmation { password }
    trait :super_admin do
      before(:create) { |user| user.roles << Role.find_or_create_by(name: :super_admin) }
    end
    factory :user_super_admin, traits: [:super_admin]
  end
end
