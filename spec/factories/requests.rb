FactoryBot.define do
  factory :request do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end

# == Schema Information
#
# Table name: requests
#
#  id          :bigint           not null, primary key
#  closed      :boolean          default(FALSE), not null
#  description :text             not null
#  slug        :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_requests_on_slug     (slug) UNIQUE
#  index_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
