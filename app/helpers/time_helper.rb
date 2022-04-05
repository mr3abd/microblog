module TimeHelper
  def timeago(time, klass = "")
    content_tag(:span, time.iso8601,
                title: time.to_s(:long),
                datetime: time.iso8601,
                class: "timeago #{klass}",
                data: { controller: "timeago" })
  end
end
