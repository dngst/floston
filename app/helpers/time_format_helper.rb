module TimeFormatHelper
  def subscription_time(date_time)
    Time.parse(date_time).strftime("%a, %b %d, %Y %H:%M:%S")
  end
end
