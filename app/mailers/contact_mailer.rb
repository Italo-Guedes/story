# frozen_string_literal: true

# Mailer for contact form, not being used
class ContactMailer < ApplicationMailer
  def contact(user)
    @user = user
    mail(to: 'contato@rdmapps.com.br', reply_to: @user.email)
  end
end
