class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    q = params[:q]
    @users = User.ransack(fname_or_lname_or_email_or_phone_number_cont: q).result(distinct: true)
    @requests = Request.ransack(title_or_description_or_cont: q).result(distinct: true)
    @articles = Article.ransack(title_or_body_cont: q).result(distinct: true)
  end
end
