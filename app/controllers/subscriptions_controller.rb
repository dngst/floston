# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  include RequireAdmin

  rescue_from SocketError, with: :handle_offline

  before_action :require_admin
  before_action :authenticate_user!
  before_action :initialize_paystack_service

  def handle_payments
    customer_exists ? initialize_transaction : create_customer
  end

  def customer_exists
    response = @paystack_service.fetch_customer_details(current_user)
    response['status']
  end

  def create_customer
    response = @paystack_service.create_customer(current_user)
    initialize_transaction if response['status']
  end

  def initialize_transaction
    response = @paystack_service.initialize_transaction(current_user)

    if response['status']
      redirect_to response['data']['authorization_url'], allow_other_host: true
    else
      redirect_with_alert('subscriptions.failed_to_initialize')
    end
  end

  def paystack_callback
    response = @paystack_service.verify_transaction(params[:reference])

    response['status'] ? create_subscription : redirect_with_alert('subscriptions.failed_verification')
  end

  def create_subscription
    response = @paystack_service.create_subscription(current_user, ENV.fetch('PLAN_ID', nil))

    if response['status']
      redirect_with_notice('subscriptions.success')
    else
      redirect_with_alert('subscriptions.failed')
    end
  end

  def manage_subscription
    session[:manage_subscription_link] = @paystack_service.get_manage_subscription_link(current_user)
    redirect_to user_path(current_user)
  end

  private

  def initialize_paystack_service
    @paystack_service = PaystackService.new(ENV.fetch('PAYSTACK_SECRET_KEY', nil))
  end

  def handle_offline
    redirect_with_alert('subscriptions.offline')
  end

  def redirect_with_alert(key)
    redirect_to user_path(current_user), alert: t(key)
  end

  def redirect_with_notice(key)
    redirect_to user_path(current_user), notice: t(key)
  end
end
