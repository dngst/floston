# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :request, counter_cache: true
  belongs_to :user
  after_create :send_new_comment_email
  validates :body, presence: true

  broadcasts_refreshes_to :request

  def self.ransackable_attributes(_auth_object = nil)
    %w[body]
  end

  private

  def send_new_comment_email
    if self. user_id == request.user.admin_id
      CommentNotificationMailer.comment_notification(request.user, request, self).deliver_later
    end
  end
end
