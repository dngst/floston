# == Schema Information
#
# Table name: tenants
#
#  id           :bigint           not null, primary key
#  amount_due   :integer
#  moved_in     :date
#  next_payment :date
#  unit_number  :string           not null
#  unit_type    :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  property_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_tenants_on_property_id  (property_id)
#  index_tenants_on_unit_number  (unit_number) UNIQUE
#  index_tenants_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (property_id => properties.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Tenant do
  it { is_expected.to validate_presence_of :unit_number }
  it { is_expected.to validate_presence_of :unit_type }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :property }
end
