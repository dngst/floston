class PaystackService
  include HTTParty
  base_uri 'https://api.paystack.co'

  def initialize(secret_key)
    @headers = {
      'Authorization' => "Bearer #{secret_key}",
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  def create_customer(current_user)
    body = {
      first_name: current_user.fname,
      last_name: current_user.lname,
      phone: current_user.phone_number,
      email: current_user.email
    }.to_json

    self.class.post('/customer', headers: @headers, body: body)
  end

  def initialize_transaction(current_user)
    body = {
      email: current_user.email,
      amount: 605.49 * 100
    }.to_json

    self.class.post('/transaction/initialize', headers: @headers, body: body)
  end

  def verify_transaction(transaction_reference)
    self.class.get("/transaction/verify/#{transaction_reference}", headers: @headers)
  end

  def create_subscription(current_user, plan_id)
    customer_code = fetch_customer_details(current_user)['data']['customer_code']
    body = {
      customer: customer_code,
      plan: plan_id
    }.to_json

    self.class.post('/subscription', headers: @headers, body: body)
  end

  def fetch_customer_details(current_user)
    response = self.class.get("/customer/#{current_user.email}", headers: @headers)
    response if response['status'] == true
  end

  def get_manage_subscription_link(current_user)
    subscription_code = fetch_customer_details(current_user)['data']['subscriptions'][0]['subscription_code']
    response = self.class.get("/subscription/#{subscription_code}/manage/link", headers: @headers)
    response['data']['link']
  end
end
