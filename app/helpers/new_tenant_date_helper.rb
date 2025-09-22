module NewTenantDateHelper
  def today
    Date.today.strftime("%Y-%m-%d")
  end

  def a_month_from_today
    (Date.today + 1.month).strftime("%Y-%m-%d")
  end
end
