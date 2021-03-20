# frozen_string_literal: true

# Preview this emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  def contact_mail
    ContactMailer.contact(User.first)
  end
end
