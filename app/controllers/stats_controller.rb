class StatsController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!, :require_admin

  def index
    @user = User.friendly.find(params[:user_id])
  end
end
