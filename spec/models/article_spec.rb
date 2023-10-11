# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  published  :boolean          default(FALSE), not null
#  slug       :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :integer          not null
#
# Indexes
#
#  index_articles_on_slug  (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe Article do
  pending "add some examples to (or delete) #{__FILE__}"
end
