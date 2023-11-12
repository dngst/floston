class SubscriptionsController < ApplicationController
  before_action :initialize_paystack_service

  def handle_payments
    response = @paystack_service.fetch_customer_details(current_user)
    if response['status'] == true
      handle_initiate_transaction
    else
      handle_customer_creation
    end
  end

  def handle_customer_creation
    response = @paystack_service.create_customer(current_user)

    return unless response['status'] == true

    handle_initiate_transaction
  end

  def handle_initiate_transaction
    response = @paystack_service.initialize_transaction(current_user)

    if response['status'] == true
      session[:transaction_reference] = response['data']['reference']
      payment_link = response['data']['authorization_url']
      redirect_to payment_link, allow_other_host: true
    else
      redirect_to user_path(current_user), alert: 'Failed to initialize transaction'
    end
  end

  def paystack_callback
    transaction_reference = session[:transaction_reference]
    response = @paystack_service.verify_transaction(transaction_reference)

    if response['status'] == true
      handle_subscription_creation
    else
      redirect_to user_path(current_user), alert: 'Transaction verification unsuccessful'
    end
  end

  def handle_subscription_creation
    response = @paystack_service.create_subscription(current_user, ENV.fetch('PLAN_ID', nil))

    if response['status'] == true
      session[:transaction_reference] = nil
      flash[:notice] = 'Subscription successful'
    else
      flash[:alert] = 'Subscription unsuccessful'
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
