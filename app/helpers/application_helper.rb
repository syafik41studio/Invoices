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

  def date_format(date)
    date.strftime("%d %B %Y")
  end

end
