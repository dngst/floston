# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/properties' do
  let(:admin) { create(:admin) }
  let(:property) { create(:property, user_id: admin.id) }

  let(:valid_attributes) do
    { name: 'New property', user_id: admin.id }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  let(:new_attributes) do
    { name: 'Updated property' }
  end

  before do
    sign_in admin
    property
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get properties_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_property_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      get edit_property_url(property)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Property' do
        expect do
          post properties_url, params: { property: valid_attributes }
        end.to change(Property, :count).by(1)
      end

      it 'redirects to created property' do
        post properties_url, params: { property: valid_attributes }
        expect(response).to redirect_to(property_url(Property.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Property' do
        expect do
          post properties_url, params: { property: invalid_attributes }
        end.not_to change(Property, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post properties_url, params: { property: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'updates the requested property' do
        patch property_url(property), params: { property: new_attributes }
        property.reload
        expect(property.name).to eq('Updated property')
      end

      it 'redirects to the property' do
        patch property_url(property), params: { property: new_attributes }
        property.reload
        expect(response).to redirect_to(property_url(property))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch property_url(property), params: { property: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested property' do
      expect do
        delete property_url(property)
      end.to change(Property, :count).by(-1)
    end

    it 'redirects to the properties list' do
      delete property_url(property)
      expect(response).to redirect_to(properties_url)
    end
  end
end
