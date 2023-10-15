require 'rails_helper'

RSpec.describe '/requests' do
  let(:admin) { create(:admin) }
  let(:user) { create(:user, admin_id: admin.id) }
  let(:request) { create(:request, user_id: user.id) }

  let(:valid_attributes) do
    { title: 'New Request', description: 'Content', user_id: user.id }
  end

  let(:new_attributes) do
    { title: 'Updated Request', description: 'New Content', user_id: user.id }
  end

  let(:invalid_attributes) do
    { title: '', description: '', user_id: user.id }
  end

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get user_requests_url(user)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get user_request_url(user, request)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_request_url(user)
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get user_request_url(user, request)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Request' do
        expect do
          post user_requests_url(user), params: { request: valid_attributes }
        end.to change(Request, :count).by(1)
      end

      it 'redirects to the created request' do
        post user_requests_url(user), params: { request: valid_attributes }
        expect(response).to redirect_to(user_request_url(user, Request.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Request' do
        expect do
          post user_requests_url(user), params: { request: invalid_attributes }
        end.not_to change(Request, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post user_requests_url(user), params: { request: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested request' do
        sign_in admin

        patch user_request_url(user, request), params: { request: new_attributes }
        request.reload
        expect(request.title).to eq('Updated Request')
        expect(request.description).to eq('New Content')
      end

      it 'redirects to the request' do
        sign_in admin

        patch user_request_url(user, request), params: { request: new_attributes }
        request.reload
        expect(response).to redirect_to(user_request_url(user, request))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        sign_in admin

        patch user_request_url(user, request), params: { request: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    xit 'destroys the requested request' do
      sign_in admin

      expect do
        delete user_request_url(user, request)
      end.to change(Request, :count).by(-1)
    end

    it 'redirects to the requests list' do
      sign_in admin

      delete user_request_url(user, request)
      expect(response).to redirect_to(user_requests_url(user))
    end
  end
end
