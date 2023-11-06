class PropertiesController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_property, only: %i[show edit update destroy]

  # GET /properties or /properties.json
  def index
    ids = Rails.cache.fetch('property_ids') do
      Property.pluck(:id)
    end
    @pagy, @properties = pagy(Property.where(id: ids, user_id: current_user.id).order(created_at: :desc))
  end

  # GET /properties/1 or /properties/1.json
  def show; end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit; end

  # POST /properties or /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save

        Rails.cache.delete('property_ids')

        format.html { redirect_to properties_url, notice: 'Property saved' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    if @property.update(property_params)
      flash.now[:notice] = 'Property updated'

      Rails.cache.delete('property_ids')

      respond_to do |format|
        format.html { redirect_to property_url(@property), notice: 'Property updated' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('update-property-form', partial: 'form', locals: { property: @property }),
            turbo_stream.replace('flash-messages', partial: 'layouts/flash')
          ]
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy
    flash.now[:notice] = 'Property deleted'

    Rails.cache.delete('property_ids')

    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property deleted' }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@property),
          turbo_stream.replace('flash-messages', partial: 'layouts/flash')
        ]
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def property_params
    params.require(:property).permit(:name, :user_id)
  end
end
