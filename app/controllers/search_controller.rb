class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    q = params[:q]
    @requests_list = if current_user&.admin?
                       Request.joins(:user).where(
                         users: { admin_id: current_user.id }
                       ).order(created_at: :desc)
                     else
                       Request.where(user_id: current_user.id).order(created_at: :desc)
                     end
    @articles_list = if current_user&.admin?
                       Article.where(admin_id: current_user.id).order(created_at: :desc)
                     else
                       Article.where(admin_id: current_user.admin_id).order(created_at: :desc)
                     end

    @users_count = User.where(admin_id: current_user.id).ransack(fname_or_lname_or_email_or_phone_number_cont: q).result(distinct: true)
    @requests_count = @requests_list.ransack(title_or_description_cont: q).result(distinct: true)
    @articles_count = @articles_list.ransack(title_or_body_cont: q).result(distinct: true)

    @users = User.where(admin_id: current_user.id).ransack(fname_or_lname_or_email_or_phone_number_cont: q).result(distinct: true).page(params[:page])
    @requests = @requests_list.ransack(title_or_description_cont: q).result(distinct: true).page(params[:page])
    @articles = @articles_list.ransack(title_or_body_cont: q).result(distinct: true).page(params[:page])
  end
end
