require 'rails_helper'

RSpec.describe 'Searches' do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  before do
    user
    admin
    sign_in user
    sign_in admin
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/search'
      expect(response).to have_http_status(:success)
    end
  end
end
