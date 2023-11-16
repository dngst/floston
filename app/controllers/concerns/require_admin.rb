module RequireAdmin
  extend ActiveSupport::Concern

  private

  def require_admin
    return if current_user&.admin?

    flash[:alert] = t('permission_denied')
    redirect_to root_path
  end
end
