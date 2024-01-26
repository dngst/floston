# frozen_string_literal: true

module CountHelper
  def format_count(count)
    return count if count < 1_000

    divisor = count < 1_000_000 ? 1_000.0 : 1_000_000.0
    formatted_value = count / divisor

    "#{format('%.1f', formatted_value).sub('.0', '')}#{count < 1_000_000 ? 'K' : 'M'}"
  end
end
