# frozen_string_literal: true

module OrdinalHelper
  def ordinal(number)
    suffix = if (11..13).cover?(number % 100)
               'th'
             else
               %w[th st nd rd th th th th th th][number % 10]
             end
    "#{number}#{suffix}"
  end
end
