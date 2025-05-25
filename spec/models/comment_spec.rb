# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :request }
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  request_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_request_id  (request_id)
#  index_comments_on_user_id     (user_id)
#
