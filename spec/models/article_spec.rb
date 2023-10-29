# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  body        :text             not null
#  published   :boolean          default(FALSE), not null
#  slug        :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_articles_on_property_id  (property_id)
#  index_articles_on_slug         (slug) UNIQUE
#  index_articles_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (property_id => properties.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Article do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :property }
end
