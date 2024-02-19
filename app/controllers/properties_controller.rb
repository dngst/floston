# frozen_string_literal: true

class PropertiesController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @pagy, @properties = pagy(Property.where(id: property_ids, user_id: current_user.id).order(created_at: :desc))
  end

  def show; end

  def new
    @property = Property.new
  end

  def edit; end

  def create
    @property = Property.new(property_params)

    if @property.save
      clear_cache
      redirect_to property_url(@property), notice: t('properties.saved')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @property.update(property_params)
      clear_cache
      redirect_to property_url(@property), notice: t('properties.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    clear_cache
    redirect_to properties_url, notice: t('properties.deleted')
  end

  private

  def set_property
    @property = Property.friendly.find(params[:id])
  end

  def property_params
    params.require(:property).permit(:name, :user_id)
  end

  def clear_cache
    Rails.cache.delete('property_ids')
  end

  def property_ids
    Rails.cache.fetch('property_ids') do
      Property.pluck(:id)
    end
  end
end
