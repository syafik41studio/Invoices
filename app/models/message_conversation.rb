class MessageConversation < ActiveRecord::Base

  belongs_to :conversation
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"

  before_create :set_default_status

  def set_default_status
    self.status_for_sender =  "Sent"
    self.status_for_recipient = "Unread"
  end

    
end
