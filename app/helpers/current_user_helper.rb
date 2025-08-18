module CurrentUserHelper
  def is_current_user?(user)
    user_signed_in? && current_user == user
  end
end
