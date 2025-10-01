# frozen_string_literal: true

class UsersController < ApplicationController
  include RequireAdmin
  include UserScoped
  include UserIsAdminHelper
  include ResourceAuthorization
  helper_method :user_is_admin?
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy authorize_profile_access]
  before_action :require_admin, only: %i[index edit update destroy]
  before_action -> { authorize_profile_access(@user) }, only: [ :edit, :update ]

  def index
    @pagy, @users = pagy(User.tenants_for(current_user))
  end

  def show
  end

  def update
    if @user.update(user_params) && @user.tenant&.update(tenant_params)
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.turbo_stream { redirect_to users_path }
      format.html { redirect_to users_path }
    end
  end

  private

  def user_params
    params.expect(user: %i[fname lname phone_number])
  end

  def tenant_params
    params.expect(tenant: %i[moved_in next_payment unit_number unit_type property_id])
  end
end
