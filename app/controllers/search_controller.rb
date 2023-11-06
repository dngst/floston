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
                       Article.where(user_id: current_user.id).order(created_at: :desc)
                     else
                       Article.where(user_id: current_user.admin_id).order(created_at: :desc)
                     end
    @properties_list = Property.where(user_id: current_user.id)
    @users_count = User
                   .where(admin_id: current_user.id)
                   .ransack(fname_or_lname_or_email_or_phone_number_or_tenant_unit_number_or_tenant_unit_type_or_tenant_property_name_cont: q)
                   .result(distinct: true)
    @requests_count = @requests_list.ransack(title_or_description_or_comments_body_or_user_fname_or_user_lname_cont: q).result(distinct: true)
    @articles_count = @articles_list.ransack(title_or_body_or_property_name_cont: q).result(distinct: true)
    @properties_count = @properties_list.ransack(name_cont: q).result(distinct: true)

    @pagy, @users = pagy(User
             .where(admin_id: current_user.id)
             .ransack(fname_or_lname_or_email_or_phone_number_or_tenant_unit_number_or_tenant_unit_type_or_tenant_property_name_cont: q)
             .result(distinct: true))
    @pagy, @requests = pagy(@requests_list.ransack(title_or_description_or_comments_body_or_user_fname_or_user_lname_cont: q).result(distinct: true))
    @pagy, @articles = pagy(@articles_list.ransack(title_or_body_or_property_name_cont: q).result(distinct: true))
    @pagy, @properties = pagy(@properties_list.ransack(name_cont: q).result(distinct: true))
  end
end
