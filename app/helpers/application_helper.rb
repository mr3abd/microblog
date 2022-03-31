module ApplicationHelper
  def icon(name, options = {})
    weight = options.delete(:weight) || "far"
    options[:class] = [weight, "fa-#{name}", options.delete(:class)]
    content_tag :i, nil, options
  end

  # rubocop:disable Rails/OutputSafety
  def line_breaks(string)
    return "" if string.blank?

    string.gsub(/\n/, "<br />").html_safe
  end
  # rubocop:enable Rails/OutputSafety
end
