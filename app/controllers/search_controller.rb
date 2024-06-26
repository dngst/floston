# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    q = params[:q]
    # authorized data to search through
    @users_list = User.where(admin_id: current_user.id).includes(:tenant)
    @requests_list = if current_user&.admin?
                       Request.joins(:user).where(
                         users: { admin_id: current_user.id }
                       ).order(created_at: :desc).includes(:user, :property)
                     else
                       Request.where(user_id: current_user.id).order(created_at: :desc).includes(:user, :property)
                     end

    @articles_list = if current_user&.admin?
                       Article.where(user_id: current_user.id).order(created_at: :desc).includes(:user)
                     else
                       Article.where(user_id: current_user.admin_id, published: true,
                                     property_id: current_user.tenant.property_id).order(created_at: :desc).includes(:user, :property)
                     end

    @properties_list = Property.where(user_id: current_user.id).includes(:user)

    # search results
    @users = @users_list.ransack(full_name_or_fname_or_lname_or_email_or_phone_number_or_tenant_unit_number_or_tenant_unit_type_or_tenant_property_name_cont: q).result(distinct: true).page(params[:page])
    @requests = @requests_list.ransack(user_full_name_or_title_or_description_or_comments_body_or_user_fname_or_user_lname_or_property_name_cont: q).result(distinct: true).joins(:property).where(properties: { name: q }).page(params[:page])
    @articles = @articles_list.ransack(title_or_body_or_property_name_cont: q).result(distinct: true).page(params[:page])
    @properties = @properties_list.ransack(name_cont: q).result(distinct: true).page(params[:page])
  end
end
