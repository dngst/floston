# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/comment_notification
class CommentNotificationPreview < ActionMailer::Preview
  def comment_notification_preview
    user = User.new(email: 'john.doe@example.com', fname: 'John', id: 1)
    request = Request.new(title: 'Request title', description: 'Request here')
    comment = Comment.new(body: 'Comment body', user_id: user.id)

    CommentNotificationMailer.comment_notification(user, request, comment)
  end
end
