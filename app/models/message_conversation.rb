class MessageConversation < ActiveRecord::Base

# == Schema Information
#
# Table name: message_conversations
#
#  id                   :integer         not null, primary key
#  conversation_id      :integer         not null
#  sender_id            :integer         not null
#  recipient_id         :integer         not null
#  body                 :text            not null
#  status_for_sender    :string(255)
#  status_for_recipient :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  message_token        :string(255)
#

  belongs_to :conversation
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"

  before_create :set_default_status


  scope :included_me, lambda{ |conversation, user|
    select("distinct on (message_token) *").where("conversation_id = ? AND(sender_id = ? OR recipient_id = ?)", conversation.id, user.id, user.id)
  }

  scope :with_body_criteria, lambda{|body|
    where("message_conversations.body like ?", "%#{body}%")
  }


  scope :my_inbox, lambda{ |user|
    where("recipient_id = ? AND status_for_recipient = ?", user.id, 'Unread')
  }

  def set_default_status
    self.status_for_sender =  "Sent"
    self.status_for_recipient = "Unread"
  end
    
end
