# frozen_string_literal: true

module UserScoped
  extend ActiveSupport::Concern

  def set_user
    user_param = params[:id] || params[:user_id]
    @user = User.friendly.find(user_param)
  end
end
