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

  def conversation_title(conversation)
    members_of_conversation = conversation.users.where("users.id <> ?", current_user.id)
    if members_of_conversation.count >= 3
      members_of_conversation[0..2].map(&:email).join(", ") + " and #{pluralize(members_of_conversation.count - 3,"other", "others")}"
    else
      members_of_conversation[0..2].map(&:email).join(", ")
    end
  end
end
