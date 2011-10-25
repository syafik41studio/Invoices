class ConversationFlag < ActiveRecord::Base

  belongs_to :conversation
  belongs_to :user

  scope :by_name, lambda{|name, user|
    includes(:user, :conversation => [:users, :messages]).where("conversation_flags.user_id <> ? AND (users.first_name||' '||users.last_name) ILIKE ?", user.id, "%#{name}%")
  }

end
