# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_presence_of :fname }
  it { is_expected.to validate_presence_of :lname }
  it { is_expected.to validate_presence_of :phone_number }
  it { is_expected.to have_one :tenant }
  it { is_expected.to have_many :requests }
  it { is_expected.to have_many :comments }
  it { is_expected.to have_many :properties }
end
