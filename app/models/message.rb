class Message < ActiveRecord::Base
  include AASM

  aasm_column :status
  aasm_initial_state :sent
  aasm_state :sent
  aasm_state :delete
  
  has_many :message_recipients
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"

  validates :message, :presence => true

  def self.search(my_account, user_id)
    begin
      user = User.find(my_account)
      recipient = User.where(:email => user_id).first
      result = user.messages.find(:all, :include => :message_recipients, :conditions => ["message_recipients.recipient_id = ?", recipient.id])
      result.empty? ? nil:recipient
    rescue
      nil
    end
  end

  def get_last_message(sender_id,current_id )
    @message_recipient = MessageRecipient.find(:last,
      :include    => :message,
      :conditions => ["(message_recipients.recipient_id = ? AND messages.sender_id = ?) or (message_recipients.recipient_id = ? AND messages.sender_id = ?) ", sender_id, current_id, current_id, sender_id],
      :order      => "message_recipients.created_at ASC"
    )
  end
end
