module RequireAdmin
  extend ActiveSupport::Concern

  private

  def require_admin
    return if current_user&.admin?

    flash[:alert] = 'You do not have permission to access this page.'
    redirect_to root_path
  end
end
