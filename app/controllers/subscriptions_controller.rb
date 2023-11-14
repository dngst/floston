class SubscriptionsController < ApplicationController
  include RequireAdmin

  before_action :require_admin
  before_action :authenticate_user!
  before_action :initialize_paystack_service

  def handle_payments
    response = @paystack_service.fetch_customer_details(current_user)
    if response['status'] == true
      initialize_transaction
    else
      create_customer
    end
  end

  def create_customer
    response = @paystack_service.create_customer(current_user)

    return unless response['status'] == true

    initialize_transaction
  end

  def initialize_transaction
    response = @paystack_service.initialize_transaction(current_user)

    if response['status'] == true
      payment_link = response['data']['authorization_url']
      redirect_to payment_link, allow_other_host: true
    else
      redirect_to user_path(current_user), alert: t('subscriptions.failed_to_initialize')
    end
  end

  def paystack_callback
    response = @paystack_service.verify_transaction(params[:reference])

    if response['status'] == true
      create_subscription
    else
      redirect_to user_path(current_user), alert: t('subscriptions.failed_verification')
    end
  end

  def create_subscription
    response = @paystack_service.create_subscription(current_user, ENV.fetch('PLAN_ID', nil))

    if response['status'] == true
      redirect_to user_path(current_user), notice: t('subscriptions.success')
    else
      redirect_to user_path(current_user), alert: t('subscriptions.failed')
    end
  end

  def manage_subscription
    response = @paystack_service.get_manage_subscription_link(current_user)
    session[:manage_subscription_link] = response
    redirect_to user_path(current_user)
  end

  private

  def initialize_paystack_service
    @paystack_service = PaystackService.new(ENV.fetch('PAYSTACK_SECRET_KEY', nil))
  end
end
