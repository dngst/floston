# frozen_string_literal: true

module TimeFormatHelper
  def subscription_time(date_time)
    Time.zone.parse(date_time).strftime("%a, %b %d, %Y %H:%M:%S")
  end
end
