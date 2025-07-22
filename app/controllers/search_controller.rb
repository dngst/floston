# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    q = params[:q]
    # authorized data to search through
    @users_list = User.where(admin_id: current_user.id)
    @requests_list = if current_user&.admin?
                       Request.joins(:user).where(
                         users: { admin_id: current_user.id }
                       ).order(created_at: :desc)
                     else
                       Request.where(user_id: current_user.id).order(created_at: :desc)
                     end
    @properties_list = Property.where(user_id: current_user.id)

    # search results
    @users = @users_list.ransack(full_name_or_fname_or_lname_or_email_or_phone_number_or_tenant_unit_number_or_tenant_unit_type_or_tenant_property_name_cont: q).result(distinct: true).page(params[:page])
    @requests = @requests_list.ransack(title_or_description_cont: q).result(distinct: true).page(params[:page])
    @properties = @properties_list.ransack(name_cont: q).result(distinct: true).page(params[:page])
  end
end
