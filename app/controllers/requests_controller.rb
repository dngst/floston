# frozen_string_literal: true

class RequestsController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!
  before_action :require_admin, only: %i[edit update destroy]
  before_action :authorize_request_access, only: [:show]
  before_action :set_user
  before_action :set_request, only: %i[show edit update destroy close_request reopen_request]

  def index
    @request_user = User.friendly.find(params[:user_id])
    @requests = if current_user&.admin?
                  admin_requests_query(request_ids).order(created_at: :desc).includes(:user)
                else
                  user_requests_query(request_ids).order(created_at: :desc).includes(:user)
                end
    @pagy, @requests = pagy(@requests, items: 20)
  end

  def show
    @user = @request.user
    @comment_count ||= @request.comments.count
    @comment = @request.comments.build(user: @user)
  end

  def new
    @request = Request.new
  end

  def edit; end

  def create
    @request = @user.requests.new(request_params)

    if @request.save
      clear_cache
      NewRequestMailer.request_notification(User.find(@request.user.admin_id), @request).deliver_later
      redirect_to user_request_url(@user, @request), notice: t('requests.saved')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @request = @user.requests.friendly.find(params[:id])
    if @request.update(request_params)
      clear_cache
      redirect_to user_request_url, notice: t('requests.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @request.destroy
    clear_cache
    redirect_to user_requests_url, notice: t('requests.deleted')
  end

  def close_request
    if @request.update(closed: true)
      redirect_to user_request_path(current_user, @request)
    else
      flash[:alert] = t('requests.failed_to_close')
      render :show
    end
  end

  def reopen_request
    if @request.update(closed: false)
      redirect_to user_request_path(current_user, @request)
    else
      flash[:alert] = t('requests.failed_to_reopen')
      render :show
    end
    clear_cache
  end

  private

  def authorize_request_access
    @request = Request.friendly.find(params[:id])
    return if current_user&.id == @request.user_id || current_user&.id == @request.user.admin_id

    flash[:alert] = t('permission_denied')
    redirect_to root_path
  end

  def set_user
    @user = User.friendly.find(params[:user_id])
  end

  def set_request
    @request = Request.friendly.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :description, :user_id, :property_id)
  end

  def clear_cache
    Rails.cache.delete('request_ids')
  end

  def admin_requests_query(ids)
    query = Request.joins(:user).where(id: ids, users: { admin_id: current_user.id })
    query = query.where(requests: { user_id: @request_user.id }) unless @request_user.admin?
    query
  end

  def user_requests_query(ids)
    Request.where(id: ids, user_id: current_user.id)
  end

  def request_ids
    Rails.cache.fetch('request_ids') do
      Request.pluck(:id)
    end
  end
end
