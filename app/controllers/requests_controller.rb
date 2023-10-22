class RequestsController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!
  before_action :require_admin, only: %i[edit update destroy]
  before_action :authorize_request_access, only: [:show]
  before_action :set_user
  before_action :set_request, only: %i[show edit update destroy close_request]

  # GET /requests or /requests.json
  def index
    ids = Rails.cache.fetch('request_ids', expires_in: 12.hours) do
      Request.pluck(:id)
    end
    @request_user = User.friendly.find(params[:user_id])
    if current_user&.admin?
      query = Request.joins(:user)
                     .where(id: ids, users: { admin_id: current_user.id })
      query = query.where(requests: { user_id: @request_user.id }) unless @request_user.admin?
      @requests = query.order(created_at: :desc).page(params[:page])
    else
      @requests = Request.where(id: ids, user_id: current_user.id).order(created_at: :desc).page(params[:page])
    end
  end

  # GET /requests/1 or /requests/1.json
  def show
    @request = Request.friendly.find(params[:id])
    @user =  @request.user
    @comment = @request.comments.build(user: @user)
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit; end

  # POST /requests or /requests.json
  def create
    @request = @user.requests.new(request_params)

    respond_to do |format|
      if @request.save
        Rails.cache.delete('request_ids')
        NewRequestMailer.request_notification(User.find(@request.user.admin_id), @request).deliver_later
        format.html { redirect_to user_request_url(@user, @request), notice: 'Request submitted' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      @request = @user.requests.friendly.find(params[:id])
      if @request.update(request_params)
        Rails.cache.delete('request_ids')
        format.html { redirect_to user_request_url, notice: 'Request was successfully updated' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy
    Rails.cache.delete('request_ids')

    respond_to do |format|
      format.html { redirect_to user_requests_url, notice: 'Request deleted' }
      format.json { head :no_content }
    end
  end

  def close_request
    @request.update_attribute(:closed, true)
    redirect_to user_request_path(current_user, @request)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def authorize_request_access
    @request = Request.friendly.find(params[:id])
    return if current_user&.id == @request.user_id || current_user&.id == @request.user.admin_id

    flash[:alert] = 'You do not have permission to access that page'
    redirect_to root_path
  end

  def set_user
    @user = User.friendly.find(params[:user_id])
  end

  def set_request
    @request = Request.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:title, :description, :user_id)
  end
end
