class Conversation < ActiveRecord::Base

  has_and_belongs_to_many :users
  has_many :messages, :class_name => "MessageConversation"

end
