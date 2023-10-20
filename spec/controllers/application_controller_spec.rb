require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def after_sign_in_path_for(resource)
      super(resource)
    end
  end

  describe '#after_sign_in_path_for' do
    let(:user) { create(:user) }
    let(:admin) { create(:admin) }

    it 'returns the edit_user_registration_path for a first-time regular user' do
      user.sign_in_count = 1
      expect(controller.after_sign_in_path_for(user)).to eq(edit_user_registration_path)
    end

    it 'returns the edit_user_registration_path for a first-time admin user' do
      admin.sign_in_count = 1
      expect(controller.after_sign_in_path_for(admin)).to eq(edit_user_registration_path)
    end

    it 'returns the users_path for an admin user' do
      expect(controller.after_sign_in_path_for(admin)).to eq(users_path)
    end

    it 'returns the user_path for a regular user' do
      expect(controller.after_sign_in_path_for(user)).to eq(user_path(user))
    end
  end
end
