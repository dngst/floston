class StatsController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!, :require_admin

  def index
    @user = User.friendly.find(params[:user_id])
    @sign_in_count ||= @user.sign_in_count
    @requests_count ||= @user.requests.size
  end
end
