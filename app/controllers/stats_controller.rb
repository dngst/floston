class StatsController < ApplicationController
  def index
    @user = User.friendly.find(params[:user_id])
  end
end
