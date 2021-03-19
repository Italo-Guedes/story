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

# User model
class User < ApplicationRecord
  include PgSearch::Model
  has_paper_trail ignore: %i[
    updated_at
    locale
    remember_created_at
    last_sign_in_at
    last_sign_in_ip
    sign_in_count
    encrypted_password
    reset_password_token
    reset_password_sent_at
    confirmation_token
    current_sign_in_at
    current_sign_in_ip
  ]
  rolify

  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  # Adicione estes três módulos se tiver cadastro
  #  :lockable
  devise :database_authenticatable, :rememberable,
         :trackable, :validatable, :recoverable, :registerable, :confirmable

  validates :email, presence: true
  validates :name, presence: true, length: { in: 1..80 }
  validates :roles, length: { maximum: 1, minimum: 1, message: 'Selecione uma regra de acesso' }
  # validates :locale, inclusion: { in: I18n.available_locales }
  has_many :notifications, dependent: :destroy

  # validate :presence_avatar
  # def presence_avatar
  #   errors.add(:avatar, 'Imagem obrigatória') unless avatar.attached?
  # end

  validate :type_avatar, if: proc { |u| u.avatar.attached? }
  def type_avatar
    errors.add(:avatar, 'Deve ser uma imagem') unless avatar.content_type.in?(%('image/jpeg image/png'))
  end

  def mark_notifications_viewed
    notifications.where(viewed: false).update_all viewed: true
  end

  def unviewed_notifications
    notifications.where(viewed: false)
  end

  def to_s
    name
  end

  def valid_password?(password)
    return true if Rails.env.development?

    super
  end

  def active_for_authentication?
    super && is_active?
  end

  def as_json(_options = nil)
    { 
      id: id,
      name: name,
      email: email,
      avatar: avatar.attached? ? 
        {
          thumb: Rails.application.routes.url_helpers.url_for(ApplicationController.helpers.square_thumb(avatar)),
          original: Rails.application.routes.url_helpers.url_for(avatar)
        } : nil,
      created_at: created_at
    }
  end

  def best_image
    Rails.application.routes.url_helpers.url_for(ApplicationController.helpers.square_thumb(avatar)) if avatar.attached?
  end

  def self.search(search, page)
    if search.present?
      paginate(per_page: 20, page: page).full_search(search)
    else
      paginate(per_page: 20, page: page)
    end
  end

  pg_search_scope :full_search,
    against: %i[email name],
    using: {tsearch: { prefix: true } },
    ignoring: :accents
end
