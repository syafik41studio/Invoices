class Conversation < ActiveRecord::Base

  has_and_belongs_to_many :users
  has_many :messages, :class_name => "MessageConversation"

  attr_accessible :recipient_tokens, :body, :owner_id
  attr_reader :recipient_tokens, :body, :owner_id

  validates :recipient_tokens, :body, :presence => true

  def list_member_conversation
    self.recipient_tokens.split(",")
  end

end
