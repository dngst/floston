# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/new_user_mailer
class NewUserMailerPreview < ActionMailer::Preview
  def login_credentials_preview
    user = User.new(email: 'john.doe@example.com', fname: 'John')
    password = '5wwD!zic'

    NewUserMailer.login_credentials(user, password)
  end
end
