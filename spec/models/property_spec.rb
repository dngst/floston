# == Schema Information
#
# Table name: properties
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_properties_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Property, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :tenants }
  it { is_expected.to have_many :articles }
end
