# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tenant do
  it { is_expected.to validate_presence_of :unit_number }
  it { is_expected.to validate_presence_of :unit_type }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :property }
end

# == Schema Information
#
# Table name: tenants
#
#  id           :integer          not null, primary key
#  unit_number  :string           not null
#  unit_type    :string           not null
#  moved_in     :date
#  next_payment :date
#  amount_due   :decimal(8, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#  property_id  :integer          not null
#
# Indexes
#
#  index_tenants_on_property_id  (property_id)
#  index_tenants_on_unit_number  (unit_number) UNIQUE
#  index_tenants_on_user_id      (user_id)
#
