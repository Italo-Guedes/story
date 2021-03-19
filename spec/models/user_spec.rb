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

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    # Presence
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:name) }

    # Length
    it { is_expected.to validate_length_of(:name).is_at_least(1).is_at_most(80) }
  end
end
