class UsersController < ApplicationController
  include RequireAdmin

  before_action :require_admin, only: %i[index edit update destroy]
  before_action :set_user, only: %i[show edit update]
  before_action :authorize_profile_access, only: [:show]

  def index
    @users = User.where(admin: false).reverse
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params) && @user.tenant.update(tenant_params)
      flash[:notice] = 'User information updated successfully.'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    return unless @user.destroy

    redirect_to users_path, notice: 'User deleted.'
  end

  private

  def authorize_profile_access
    @user = User.friendly.find(params[:id])

    return if current_user == @user

    flash[:alert] = 'You do not have permission to access this page.'
    redirect_to root_path
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:fname, :lname, :phone_number, :email, :admin)
  end

  def tenant_params
    params.require(:tenant).permit(:amount_due, :moved_in, :next_payment, :unit_number, :unit_type)
  end
end
