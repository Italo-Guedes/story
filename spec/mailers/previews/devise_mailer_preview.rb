# frozen_string_literal: true

# Preview this emails at http://localhost:3000/rails/mailers/devise_mailer
class DeviseMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    DeviseMailer.confirmation_instructions(User.first, 'faketoken', {})
  end

  def reset_password_instructions
    DeviseMailer.reset_password_instructions(User.first, 'faketoken', {})
  end

  def unlock_instructions
    DeviseMailer.unlock_instructions(User.first, 'faketoken', {})
  end
end
