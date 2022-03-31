module ApplicationHelper
  def icon(name, options = {})
    weight = options.delete(:weight) || "far"
    options[:class] = [weight, "fa-#{name}", options.delete(:class)]
    content_tag :i, nil, options
  end
end
