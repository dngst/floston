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
class Article < ApplicationRecord
  extend FriendlyId

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end
end
