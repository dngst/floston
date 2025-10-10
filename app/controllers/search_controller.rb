# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    @query = params[:q]
    @pagy_users, @users = pagy(search_users(@query), page_param: :page_users)
    @pagy_requests, @requests = pagy(search_requests(@query), page_param: :page_requests)
    @pagy_properties, @properties = pagy(search_properties(@query), page_param: :page_properties)
  end

  private

  def search_users(query)
    User.by_admin(current_user)
      .ransack(full_name_or_fname_or_lname_or_email_or_phone_number_or_tenant_unit_number_or_tenant_unit_type_or_tenant_property_name_cont: query)
      .result(distinct: true)
  end

  def search_requests(query)
    Request.by_user_scope(current_user)
      .ransack(title_or_description_or_user_full_name_cont: query)
      .result(distinct: true)
  end

  def search_properties(query)
    Property.by_user(current_user)
      .ransack(name_cont: query)
      .result(distinct: true)
  end
end
