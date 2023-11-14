class UsersController < ApplicationController
  include RequireAdmin

  before_action :require_admin, only: %i[index edit update destroy]
  before_action :set_user, only: %i[show edit update destroy authorize_profile_access]
  before_action :authorize_profile_access, only: [:show]
  before_action :authenticate_user!
  before_action :initialize_paystack_service, only: [:show]
  before_action :handle_customer_details, only: [:show]

  def index
    ids = Rails.cache.fetch('tenant_ids') do
      User.pluck(:id)
    end
    tenants_list = User.where(id: ids, admin: false, admin_id: current_user.id).order(created_at: :desc)
    @pagy, @users = pagy(tenants_list)
  end

  def show
    @payout = Tenant.total_amount_due(@user)
  end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        Rails.cache.delete('tenant_ids')
        if @user.tenant
          if @user.tenant.update(tenant_params)
            Rails.cache.delete('tenant_ids')
            format.html { redirect_to user_path(@user), notice: t('users.updated') }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @user.tenant.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to user_path(@user), notice: t('users.updated') }
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

    flash.now[:notice] = t('users.deleted')
    Rails.cache.delete('tenant_ids')

    respond_to do |format|
      format.html { redirect_to users_path, notice: t('users.deleted') }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@user),
          turbo_stream.replace('flash-messages', partial: 'layouts/flash')
        ]
      end
    end
  end

  private

  def authorize_profile_access
    return if current_user&.id == @user.admin_id || current_user == @user

    flash[:alert] = t('permission_denied')
    redirect_to root_path
  end

  def initialize_paystack_service
    @paystack_service = PaystackService.new(ENV.fetch('PAYSTACK_SECRET_KEY', nil))
  end

  def handle_customer_details
    response = @paystack_service.fetch_customer_details(current_user)
    return unless response && response['status'] == true

    @subscribed = response['data']['subscriptions']
    @card_details = response['data']['authorizations'][0]
    @subscription_details = response['data']['subscriptions'][0]
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
