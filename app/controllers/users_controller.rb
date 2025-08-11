# frozen_string_literal: true

class UsersController < ApplicationController
  include RequireAdmin
  include UserScoped
  include UserIsAdminHelper
  helper_method :user_is_admin?

  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy authorize_profile_access]
  before_action :require_admin, only: %i[index edit update destroy]
  before_action :authorize_profile_access, only: [ :show ]

  def index
    @pagy, @users = pagy(User.tenants_for(current_user.id))
  end

  def show
    @payout = Tenant.total_amount_due(@user)
  end

  def edit; end

  def update
    if @user.update(user_params) && @user.tenant&.update(tenant_params)
      redirect_to user_path(@user), notice: t("users.updated")
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: t("users.deleted")
  end

  private

  def authorize_profile_access
    return if current_user&.id == @user.admin_id || current_user == @user

    flash[:alert] = t("permission_denied")
    redirect_to root_path
  end

  def user_params
    params.expect(user: %i[fname lname phone_number])
  end

  def tenant_params
    params.expect(tenant: %i[amount_due moved_in next_payment unit_number unit_type property_id])
  end
end
