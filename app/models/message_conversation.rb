class MessageConversation < ActiveRecord::Base

  attr_accessible :recipient_tokens
  attr_reader :recipient_tokens

  validates :recipient_tokens, :presence => true

    
end
