# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fname                  :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  lname                  :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  slug                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin_id               :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_presence_of :fname }
  it { is_expected.to validate_presence_of :lname }
  it { is_expected.to validate_presence_of :phone_number }
end
