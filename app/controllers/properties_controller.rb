class PropertiesController < ApplicationController
  include RequireAdmin

  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_property, only: %i[show edit update destroy]

  # GET /properties or /properties.json
  def index
    ids = Rails.cache.fetch('property_ids', expires_in: 12.hours) do
      Property.pluck(:id)
    end
    @properties = Property.where(id: ids, user_id: current_user.id).order(created_at: :desc)
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
        format.html { redirect_to properties_url, notice: 'Property was successfully created' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        Rails.cache.delete('property_ids')
        format.html { redirect_to property_url(@property), notice: 'Property was successfully updated' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy
    Rails.cache.delete('property_ids')

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@property) }
      format.html { redirect_to properties_url, notice: 'Property was successfully deleted' }
      format.json { head :no_content }
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
