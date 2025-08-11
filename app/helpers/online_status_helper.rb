# frozen_string_literal: true

module OnlineStatusHelper
  require "httparty"

  def online?
    response = HTTParty.get("https://www.google.com")
    response.success?
  rescue StandardError
    false
  end
end
