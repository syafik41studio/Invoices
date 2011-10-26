class ConversationFlag < ActiveRecord::Base

# == Schema Information
#
# Table name: conversation_flags
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  conversation_id :integer
#  status          :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#


  belongs_to :conversation
  belongs_to :user

  scope :by_name, lambda{|name, user|
    includes(:user, :conversation => [:users, :messages]).where("conversation_flags.user_id <> ? AND (users.first_name||' '||users.last_name) ILIKE ?", user.id, "%#{name}%")
  }

end