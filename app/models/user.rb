class User < ActiveRecord::Base

  has_and_belongs_to_many :roles
  has_and_belongs_to_many :conversations
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :messages, :foreign_key => "sender_id"

  def get_last_message(sender_id,current_id )
    @message_recipient = MessageRecipient.find(:last,
      :include    => :message,
      :conditions => ["(message_recipients.recipient_id = ? AND messages.sender_id = ?) or (message_recipients.recipient_id = ? AND messages.sender_id = ?) ", sender_id, current_id, current_id, sender_id],
      :order      => "message_recipients.created_at ASC"
    )
  end

  def inbox
    conversations.includes(:messages).where("recipient_id = ? AND status_for_recipient = ?", self.id, 'unread')
  end
  
end
