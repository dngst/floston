require 'rails_helper'

RSpec.describe 'Searches' do
  before do
    user = create(:user)
    sign_in user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/search'
      expect(response).to have_http_status(:success)
    end
  end
end
