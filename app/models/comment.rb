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
