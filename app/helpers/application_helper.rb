module ApplicationHelper
  def ordinal(number)
    if (11..13).cover?(number % 100)
      "#{number}th"
    else
      case number % 10
      when 1
        "#{number}st"
      when 2
        "#{number}nd"
      when 3
        "#{number}rd"
      else
        "#{number}th"
      end
    end
  end

  def active_link_to(link_text, path, html_options = {})
    html_options[:class] = [html_options[:class], 'active'].compact.join(' ') if current_page?(path)
    link_to link_text, path, html_options
  end
end
