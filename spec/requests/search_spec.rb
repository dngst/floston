# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Searches' do
  let(:admin) { create(:admin) }
  let(:property) { create(:property, user_id: admin.id) }
  let(:user) { create(:user, admin_id: admin.id, tenant_attributes_override: { property_id: property.id }) }

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
