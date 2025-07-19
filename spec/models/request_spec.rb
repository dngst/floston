# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :comments }
end
