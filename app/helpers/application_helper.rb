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

  def conversation_photos(conversation, user = current_user)
    members_of_conversation = conversation.users.where("users.id <> ?", user.id)
    profiles = members_of_conversation[0..3].map{|u| u.profile}
    photos = []
    profiles.each do |p|
      photo_url = p.nil? ? "/images/photo.png" : p.avatar.url(:thumb)
      photos.push(content_tag(:div, image_tag(photo_url, :height => 20, :width => 20), :style => "float:left;height:20px;width:20px") )
    end
    photos.join(" ").html_safe
  end

  def conversation_title_photo(conversation, user = current_user)
    members_of_conversation = conversation.users.where("users.id <> ?", user.id)
    profile = members_of_conversation[0].profile
    photo_url = if profile and !profile.avatar_file_name.blank?
      profile.avatar.url(:medium)
    else
      "/images/photo.png"
    end
    image_tag(photo_url)
  end

  def photo_profile(profile)
    photo_url = if profile and !profile.avatar_file_name.blank?
      profile.avatar.url(:medium)
    else
      "/images/photo.png"
    end
    image_tag(photo_url,:width => "50px", :height => "50px")
  end

end
