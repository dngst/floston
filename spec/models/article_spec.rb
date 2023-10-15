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
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :admin_id }
end
