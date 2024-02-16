# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if current_user&.admin?
      redirect_to users_path
    elsif current_user
      redirect_to user_path(current_user)
    else
      @home_page = true
    end
  end
end
