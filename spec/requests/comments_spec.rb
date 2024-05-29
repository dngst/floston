# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/comments' do
  let(:admin) { create(:admin) }
  let(:property) { create(:property, user_id: admin.id) }
  let(:request) { create(:request, user_id: user.id, property_id: property.id) }
  let(:user) { create(:user, admin_id: admin.id, tenant_attributes_override: { property_id: property.id }) }

  let(:valid_attributes) do
    { body: 'Content', user_id: user.id }
  end

  let(:invalid_attributes) do
    { body: '', user_id: user.id }
  end

  before do
    sign_in user
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Comment' do
        expect do
          post user_request_comments_url(user, request), params: { comment: valid_attributes }
        end.to change(Comment, :count).by(1)
      end

      it 'redirects to the created comment' do
        post user_request_comments_url(user, request), params: { comment: valid_attributes }
        expect(response).to redirect_to(user_request_url(user, request))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Comment' do
        expect do
          post user_request_comments_url(user, request), params: { comment: invalid_attributes }
        end.not_to change(Comment, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post user_request_comments_url(user, request), params: { comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
