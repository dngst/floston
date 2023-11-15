class CommentNotificationMailer < ApplicationMailer
  def comment_notification(user, request, comment)
    @user = user
    @request = request
    @comment = comment
    mail(to: @user.email, subject: t('mailer.new_comment.subject'))
  end
end
