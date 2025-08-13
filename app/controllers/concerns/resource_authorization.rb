module ResourceAuthorization
  extend ActiveSupport::Concern

  included do
    helper_method :can_access_profile?, :can_access_request?
  end

  private

  def can_access_profile?(user)
    current_user&.id == user.admin_id || current_user == user
  end

  def authorize_profile_access(user)
    return if can_access_profile?(user)
    deny_access
  end

  def can_access_request?(request)
    current_user&.id == request.user_id ||
      current_user&.id == request.user.admin_id
  end

  def authorize_request_access(request)
    return if can_access_request?(request)
    deny_access
  end

  def deny_access
    flash[:alert] = t("permission_denied")
    redirect_to root_path
  end
end
