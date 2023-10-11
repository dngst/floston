# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  request_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_request_id  (request_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (request_id => requests.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment do
  it { is_expected.to validate_presence_of :body }
end
