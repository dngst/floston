# frozen_string_literal: true

class RequestsController < ApplicationController
  include RequireAdmin
  include RequestScoped
  include ResourceAuthorization
  before_action :authenticate_user!
  before_action :require_admin, only: %i[update destroy]
  before_action :set_user
  before_action :set_request, only: %i[show update destroy close_request reopen_request]
  before_action -> { authorize_request_access(@request) }, only: [ :show ]

  def index
    @request_user = User.friendly.find(params[:user_id])
    @requests = Request.by_user_scope(current_user)
    @pagy, @requests = pagy(@requests, items: 20)
  end

  def show
    @user = @request.user
    @comment = @request.comments.build(user: @user)
  end

  def new
    @request = Request.new
  end

  def create
    @request = @user.requests.new(request_params)
    if @request.save
      NewRequestMailer.request_notification(User.find(@request.user.admin_id), @request).deliver_later
      redirect_to user_request_url(@user, @request), notice: t("requests.saved")
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    @request = @user.requests.friendly.find(params[:id])
    if @request.update(request_params)
      redirect_to user_request_url, notice: t("requests.updated")
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @request.destroy
    redirect_to user_requests_url, notice: t("requests.deleted")
  end

  def close_request
    if @request.update(closed: true)
      redirect_to user_request_path(current_user, @request)
    else
      flash[:alert] = t("requests.failed_to_close")
      render :show
    end
  end

  def reopen_request
    if @request.update(closed: false)
      redirect_to user_request_path(current_user, @request)
    else
      flash[:alert] = t("requests.failed_to_reopen")
      render :show
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:user_id])
  end

  def request_params
    params.expect(request: %i[title description user_id property_id])
  end

  def admin_requests_query
    Request
      .joins(:user)
      .where(users: { admin_id: current_user.id })
      .then do |query|
        @request_user.admin? ? query : query.where(user_id: @request_user.id)
      end
  end

  def user_requests_query
    Request.where(user_id: current_user.id)
  end
end
