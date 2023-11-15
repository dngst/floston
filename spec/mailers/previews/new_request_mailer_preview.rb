# Preview all emails at http://localhost:3000/rails/mailers/new_request_mailer
class NewRequestMailerPreview < ActionMailer::Preview
  def request_notification
    user = User.new(email: 'john.doe@example.com', fname: 'John', id: 1)
    request = Request.new(title: 'Request title', description: 'Request here', user_id: user.id)

    NewRequestMailer.request_notification(user, request)
  end
end
