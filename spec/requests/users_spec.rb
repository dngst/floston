# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  let(:admin) { create(:admin) }
  let(:property) { create(:property, user_id: admin.id) }
  let(:user) { create(:user, admin_id: admin.id, tenant_attributes_override: { property_id: property.id }) }

  let(:valid_user_attributes) do
    {
      email: 'user@example.com',
      password: 'password',
      fname: 'John',
      lname: 'Doe',
      phone_number: '0715948650'
    }
  end

  let(:valid_tenant_attributes) do
    {
      unit_number: 'B30',
      unit_type: '1 Bedroom'
    }
  end

  let(:new_user_attributes) do
    { fname: 'James', lname: 'Dean' }
  end

  let(:new_tenant_attributes) do
    { unit_number: 'A07', unit_type: '3 Bedroom' }
  end

  let(:invalid_user_attributes) do
    { email: '', password: '', fname: '', lname: '', phone_number: '' }
  end

  let(:invalid_tenant_attributes) do
    {
      unit_number: '',
      unit_type: ''
    }
  end

  before do
    user
    admin
  end

  describe 'GET /index' do
    it 'returns http success' do
      sign_in admin

      get '/users'
      expect(response).to have_http_status(:success)
    end

    it 'requires admin access' do
      sign_in user

      get '/users'
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('You do not have permission to access that page')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      sign_in admin

      get user_path(user)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      sign_in admin

      get new_user_registration_path
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      sign_in admin

      get edit_user_registration_path(user)
      expect(response).to be_successful
    end

    it 'requires admin access' do
      sign_in user

      get edit_user_path(user)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('You do not have permission to access that page')
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        sign_in admin

        expect do
          post user_registration_path, params: { user: valid_user_attributes, tenant: valid_tenant_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        sign_in admin

        post user_registration_path, params: { user: valid_user_attributes, tenant: valid_tenant_attributes }
        expect(response).to redirect_to(user_path(User.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        sign_in admin

        expect do
          post user_registration_path, params: { user: invalid_user_attributes, tenant: invalid_tenant_attributes }
        end.not_to change(User, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        sign_in admin

        post user_registration_path, params: { user: invalid_user_attributes, tenant: invalid_tenant_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'requires admin access' do
        sign_in user

        patch user_path(user, format: :html), params: { user: new_user_attributes, tenant: new_tenant_attributes }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq('You do not have permission to access that page')
      end

      it 'updates the requested user' do
        sign_in admin

        patch user_path(user, format: :html), params: { user: new_user_attributes, tenant: new_tenant_attributes }
        user.reload
        expect(user.fname).to eq('James')
        expect(user.lname).to eq('Dean')
        expect(user.tenant.unit_number).to eq('A07')
        expect(user.tenant.unit_type).to eq('3 Bedroom')
      end

      it 'redirects to the user' do
        sign_in admin

        patch user_path(user), params: { user: new_user_attributes, tenant: new_tenant_attributes }
        user.reload
        expect(response).to redirect_to(user_path(user))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        sign_in admin

        patch user_path(user), params: { user: invalid_user_attributes, tenant: invalid_tenant_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'requires admin access' do
      sign_in user

      delete user_path(user, format: :html)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('You do not have permission to access that page')
    end

    it 'destroys the requested user' do
      sign_in admin

      expect do
        delete user_path(user, format: :html)
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      sign_in admin

      delete user_path(user, format: :html)
      expect(response).to redirect_to(users_path)
    end
  end
end
