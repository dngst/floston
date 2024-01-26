# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @home_page = true
    if current_user&.admin?
      redirect_to users_path
    elsif current_user.present?
      redirect_to user_path(current_user)
    end
  end
end
