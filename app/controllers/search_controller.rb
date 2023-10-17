class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    q = params[:q]
    @users = User.ransack(fname_or_lname_or_email_or_phone_number_cont: q).result(distinct: true).page(params[:page])
    @requests = Request.ransack(title_or_description_or_cont: q).result(distinct: true).page(params[:page])
    @articles = Article.ransack(title_or_body_cont: q).result(distinct: true).page(params[:page])

    @users_count = User.ransack(fname_or_lname_or_email_or_phone_number_cont: q).result(distinct: true)
    @requests_count = Request.ransack(title_or_description_or_cont: q).result(distinct: true)
    @articles_count = Article.ransack(title_or_body_cont: q).result(distinct: true)
  end
end
