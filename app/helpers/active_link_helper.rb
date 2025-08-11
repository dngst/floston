# frozen_string_literal: true

module ActiveLinkHelper
  def active_link_to(link_text, path, html_options = {})
    html_options[:class] = [ html_options[:class], "active" ].compact.join(" ") if current_page?(path)
    link_to link_text, path, html_options
  end
end
