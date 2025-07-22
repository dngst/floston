# frozen_string_literal: true

module UserScopable
  extend ActiveSupport::Concern

  included do
    scope :by_user, ->(user) { where(user_id: user.id) }
  end
end
