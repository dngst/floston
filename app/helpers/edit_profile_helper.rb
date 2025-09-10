module EditProfileHelper
  def current_user?(user)
    user.present? && user == current_user
  end

  def show_edit_profile_link?(user)
    user_signed_in? && current_user?(user)
  end

  def show_admin_actions?(user)
    user_is_admin? && !current_user?(user)
  end
end
