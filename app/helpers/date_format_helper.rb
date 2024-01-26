# frozen_string_literal: true

module DateFormatHelper
  def date_format(date)
    date.strftime('%b %d, %Y')
  end
end
