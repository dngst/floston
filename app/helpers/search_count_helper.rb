module SearchCountHelper
  def show_count(records, term)
    pluralize(format_count(records.count), "#{term}")
  end
end
