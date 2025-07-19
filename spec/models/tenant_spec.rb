# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tenant do
  it { is_expected.to validate_presence_of :unit_number }
  it { is_expected.to validate_presence_of :unit_type }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :property }
end
