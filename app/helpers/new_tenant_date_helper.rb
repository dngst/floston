module NewTenantDateHelper
  def today
    Date.today
  end

  def a_month_from_today
    Date.today + 1.month
  end
end
