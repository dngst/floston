# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    name { Faker::Address.street_name }
  end
end

# == Schema Information
#
# Table name: properties
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  slug          :string
#  tenants_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_properties_on_slug     (slug) UNIQUE
#  index_properties_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
