module AmountDueHelper
  def formatted_amount_due(property_id)
    amount = Property.find_by(id: property_id)&.amount_due
    number_to_currency(amount, unit: "$") if amount
  end
end
