# frozen_string_literal: true

class UsersController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy authorize_profile_access]
  before_action :require_admin, only: %i[index edit update destroy]
  before_action :authorize_profile_access, only: [:show]
  before_action :initialize_paystack_service, only: [:show]
  before_action :handle_customer_details, only: [:show]

  def index
    tenants_list = User.where(id: user_ids, admin: false, admin_id: current_user.id).order(created_at: :desc)
    @pagy, @users = pagy(tenants_list)
  end

  def show
    @payout = Tenant.total_amount_due(@user)
  end

  def edit; end

  def update
    if @user.update(user_params) && @user.tenant&.update(tenant_params)
      redirect_to user_path(@user), notice: t('users.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    clear_cache
    redirect_to users_path, notice: t('users.deleted')
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
    return unless current_user&.admin? && current_user == @user

    response = @paystack_service.fetch_customer_details(current_user)
    return unless response && response['status']

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

  def clear_cache
    Rails.cache.delete('tenant_ids')
  end

  def user_ids
    Rails.cache.fetch('tenant_ids') do
      User.pluck(:id)
    end
  end
end
