module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = I18n.t 'site.name'
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def custom_time(time)
    distance = distance_of_time_in_words(time, Time.now)
    if distance.include?("1 day")
      "Yesterday"
    elsif distance.include?("days")
      time.strftime("%A")
    elsif distance.include?("month")
      time.strftime("%B %d")
    elsif distance.include?("year")
      time.strftime("%B %d, %Y")
    else
      distance + " ago"
    end
  end
end
