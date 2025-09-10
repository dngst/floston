module PropertyNameHelper
  def show_property_name(property_id)
    Property.find_by(id: property_id)&.name
  end
end
