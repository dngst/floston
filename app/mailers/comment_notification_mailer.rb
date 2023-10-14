class CommentNotificationMailer < ApplicationMailer
  def comment_notification(user, request, comment)
    @user = user
    @request = request
    @comment = comment
    mail(to: @user.email, subject: 'New comment on your request')
  end
end
