require 'rails_helper'

RSpec.describe 'Users' do
  let(:admin) { create(:admin) }
  let(:user) { create(:user, admin_id: admin.id) }

  before do
    sign_in admin
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get user_path(user)
      expect(response).to be_successful
    end
  end
end
