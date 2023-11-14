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

  def create_customer(user)
    body = {
      first_name: user.fname,
      last_name: user.lname,
      phone: user.phone_number,
      email: user.email
    }.to_json

    self.class.post('/customer', headers: @headers, body:)
  end

  def initialize_transaction(user)
    body = {
      email: user.email,
      amount: 605.49 * 100
    }.to_json

    self.class.post('/transaction/initialize', headers: @headers, body:)
  end

  def verify_transaction(transaction_reference)
    self.class.get("/transaction/verify/#{transaction_reference}", headers: @headers)
  end

  def create_subscription(user, plan_id)
    customer_code = fetch_customer_details(user)['data']['customer_code']
    body = {
      customer: customer_code,
      plan: plan_id
    }.to_json

    self.class.post('/subscription', headers: @headers, body:)
  end

  def fetch_customer_details(user)
    self.class.get("/customer/#{user.email}", headers: @headers)
  end

  def get_subscription_code(user)
    fetch_customer_details(user)['data']['subscriptions'][0]['subscription_code']
  end

  def get_manage_subscription_link(user)
    subscription_code = get_subscription_code(user)
    response = self.class.get("/subscription/#{subscription_code}/manage/link", headers: @headers)
    response['data']['link']
  end
end
