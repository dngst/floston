# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    @query = params[:q]
    @users = search_users(@query)
    @requests = search_requests(@query)
    @properties = search_properties(@query)
  end

  private

  def search_users(query)
    User.by_admin(current_user)
        .ransack(full_name_or_fname_or_lname_or_email_or_phone_number_or_tenant_unit_number_or_tenant_unit_type_or_tenant_property_name_cont: query)
        .result(distinct: true)
        .page(params[:page])
  end

  def search_requests(query)
    Request.by_user_scope(current_user)
           .ransack(title_or_description_cont: query)
           .result(distinct: true)
           .page(params[:page])
  end

  def search_properties(query)
    Property.by_user(current_user)
            .ransack(name_cont: query)
            .result(distinct: true)
            .page(params[:page])
  end
end
