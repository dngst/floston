# frozen_string_literal: true

module AdminScopable
  extend ActiveSupport::Concern

  included do
    scope :by_admin, ->(admin) { where(admin_id: admin.id) }
  end
end
