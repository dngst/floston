# == Schema Information
#
# Table name: tenants
#
#  id           :bigint           not null, primary key
#  amount_due   :integer
#  moved_in     :date
#  next_payment :date
#  unit_number  :string
#  unit_type    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_tenants_on_unit_number  (unit_number) UNIQUE
#  index_tenants_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Tenant < ApplicationRecord
end
