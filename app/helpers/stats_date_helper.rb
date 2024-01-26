# frozen_string_literal: true

module StatsDateHelper
  def format_stats_datetime(datetime)
    datetime&.strftime("%a, #{datetime.day} %b %Y at %I:%M %p")
  end
end
