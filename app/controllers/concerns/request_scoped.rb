# frozen_string_literal: true

module RequestScoped
  extend ActiveSupport::Concern

  def set_request
    @request = Request.friendly.find(params[:id])
  end
end
