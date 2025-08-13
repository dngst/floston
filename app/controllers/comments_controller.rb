# frozen_string_literal: true

class CommentsController < ApplicationController
  include UserScoped
  before_action :set_user, :set_request
  before_action :set_comment, only: %i[show edit update destroy]

  def create
    @comment = @request.comments.build(comment_params)
    if @comment.save
      send_new_comment_email(@request, @comment)
      handle_create_success
    else
      render "requests/show", status: :unprocessable_content
    end
  end

  private

  def set_comment
    @comment = @request.comments.find(params[:id])
  end

  def set_request
    @request = @user.requests.friendly.find(params[:request_id])
  end

  def comment_params
    params.expect(comment: %i[body request_id user_id])
  end

  def send_new_comment_email(request, comment)
    return unless comment.user_id == request.user.admin_id
    CommentNotificationMailer.comment_notification(request.user, request, comment).deliver_later
  end

  def handle_create_success
    respond_to do |format|
      format.html { redirect_to user_request_path(@user, @request) }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append("comments", partial: "comments/comment", locals: { comment: @comment }),
          turbo_stream.replace("comment_counter", partial: "requests/comment_counter",
                                                  locals: { counter: @request.comments_count })
        ]
      end
    end
  end
end
