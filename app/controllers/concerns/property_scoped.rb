# frozen_string_literal: true

module PropertyScoped
  extend ActiveSupport::Concern

  private

  def set_property
    @property = Property.friendly.find(params[:id])
  end
end
