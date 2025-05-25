# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :request
  belongs_to :user

  validates :body, presence: true

  broadcasts_refreshes_to :request

  def self.ransackable_attributes(_auth_object = nil)
    %w[body]
  end
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  request_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_request_id  (request_id)
#  index_comments_on_user_id     (user_id)
#
