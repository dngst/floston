class CommentsController < ApplicationController
  before_action :set_request
  before_action :set_user
  before_action :set_comment, only: %i[show edit update destroy]

  def index; end

  # GET /comments/1 or /comments/1.json
  def show; end

  # GET /users/:user_id/requests/:request_id/comments/new
  def new; end

  # GET /comments/1/edit
  def edit; end

  # POST /users/:user_id/requests/:request_id/comments or /users/:user_id/requests/:request_id/comments.json
  def create
    @comment = @request.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        if @comment.user_id == @request.user.admin_id
          CommentNotificationMailer.comment_notification(@request.user, @request, @comment).deliver_now
        end
        format.html { redirect_to user_request_path(@user, @request), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: user_request_comment_path(@user, @request, @comment) }
      else
        format.html { render 'requests/show', status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html do
          redirect_to user_request_comment_path(@user, @request, @comment), notice: 'Comment was successfully updated.'
        end
        format.json { render :show, status: :ok, location: user_request_comment_path(@user, @request, @comment) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to user_request_path(@user, @request), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.friendly.find(params[:user_id])
  end

  def set_comment
    @comment = @request.comments.find(params[:id])
  end

  def set_request
    @user = User.friendly.find(params[:user_id])
    @request = @user.requests.friendly.find(params[:request_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body, :request_id, :user_id)
  end
end
