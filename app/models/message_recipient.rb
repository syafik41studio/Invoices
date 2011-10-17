class MessageRecipient < ActiveRecord::Base
  include AASM
  attr_accessor :email
  aasm_column :status

  aasm_initial_state :unread
  aasm_state :unread
  aasm_state :read
  aasm_state :delete
  
  belongs_to :message
  belongs_to :receiver, :class_name => "User", :foreign_key => "recipient_id"
  before_create :get_user_id
  
  def get_user_id
    self.recipient_id = User.where(:email => self.email).first.id 
  end

  def self.get_unread(user_id)
    self.where(:recipient_id => user_id, :status => "unread").includes(:message)
  end
  
end
