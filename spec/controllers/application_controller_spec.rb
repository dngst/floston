# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def after_sign_in_path_for(resource)
      super
    end
  end

  describe '#after_sign_in_path_for' do
    let(:admin) { create(:admin) }
    let(:property) { create(:property, user_id: admin.id) }
    let(:user) { create(:user, tenant_attributes_override: { property_id: property.id }) }

    context 'when first-time regular user' do
      it 'returns the edit_user_registration_path' do
        user.sign_in_count = 1
        expect(controller.after_sign_in_path_for(user)).to eq(edit_user_registration_path)
      end
    end

    context 'when first-time admin user' do
      it 'returns the edit_user_registration_path' do
        admin.sign_in_count = 1
        expect(controller.after_sign_in_path_for(admin)).to eq(edit_user_registration_path)
      end
    end

    context 'when admin user' do
      it 'returns the users_path' do
        expect(controller.after_sign_in_path_for(admin)).to eq(users_path)
      end
    end

    context 'when regular user' do
      it 'returns the user_path' do
        expect(controller.after_sign_in_path_for(user)).to eq(user_path(user))
      end
    end
  end
end
