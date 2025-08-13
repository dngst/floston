# frozen_string_literal: true

class PropertiesController < ApplicationController
  include RequireAdmin
  include PropertyScoped
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @pagy, @properties = pagy(Property.where(
      user_id: current_user.id
    ).ordered)
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to property_url(@property), notice: t("properties.saved")
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @property.update(property_params)
      redirect_to property_url(@property), notice: t("properties.updated")
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_url, notice: t("properties.deleted")
  end

  private

  def property_params
    params.expect(property: %i[name user_id])
  end
end
