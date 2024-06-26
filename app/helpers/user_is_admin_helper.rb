# frozen_string_literal: true

module UserIsAdminHelper
  def user_is_admin?
    current_user&.admin
  end
end
