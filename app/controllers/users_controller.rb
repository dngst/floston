class UsersController < ApplicationController
  include RequireAdmin

  before_action :require_admin, only: %i[index edit update destroy]
  before_action :set_user, only: %i[show edit update destroy authorize_profile_access]
  before_action :authorize_profile_access, only: [:show]
  before_action :authenticate_user!

  def index
    users_list = User.where(admin: false, admin_id: current_user.id).order(created_at: :desc).page(params[:page])
    @users = users_list
    set_page_and_extract_portion_from users_list
  end

  def show
    @payout = Tenant.total_amount_due(@user)
  end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        if @user.tenant
          if @user.tenant.update(tenant_params)
            format.html { redirect_to user_path(@user), notice: 'Tenant information updated' }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @user.tenant.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to user_path(@user), notice: 'User information updated' }
          format.json { render :show, status: :ok, location: @user }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    set_page_and_extract_portion_from User.where(admin: false,
                                                 admin_id: current_user.id).order(created_at: :desc).page(params[:page])

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = 'Tenant deleted.'
        redirect_to users_path
      end
      format.html { redirect_to users_path, notice: 'Tenant deleted.' }
    end
  end

  private

  def authorize_profile_access
    return if current_user&.id == @user.admin_id || current_user == @user

    flash[:alert] = 'You do not have permission to access that page'
    redirect_to root_path
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:fname, :lname, :phone_number)
  end

  def tenant_params
    params.require(:tenant).permit(:amount_due, :moved_in, :next_payment, :unit_number, :unit_type, :property_id)
  end
end
