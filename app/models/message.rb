class Message < ActiveRecord::Base
  include AASM

  aasm_column :status
  aasm_initial_state :sent
  aasm_state :sent
  aasm_state :delete
  
  has_many :message_recipients
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"

  validates :message, :presence => true
    
end
