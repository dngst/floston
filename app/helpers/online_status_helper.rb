# frozen_string_literal: true

module OnlineStatusHelper
  require 'net/http'

  def online?
    url = URI.parse('https://www.google.com')
    response = Net::HTTP.get_response(url)
    response.is_a?(Net::HTTPSuccess)
  rescue StandardError
    false
  end
end
