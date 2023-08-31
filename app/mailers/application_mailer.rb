# frozen_string_literal: true

# Base class for all application mailers
class ApplicationMailer < ActionMailer::Base
  default from: 'contato@roadmaps.com.br'
  layout 'mailer'

  def mail(options = {})
    if Rails.env.development?
      if ENV['DEV_EMAIL'].blank?
        raise 'Configure a ENV DEV_EMAIL com seu endereço e-mail para receber e-mails em desenvolvimento'
      end

      options[:to] = ENV['DEV_EMAIL']
    end

    super(options)
  end
end
