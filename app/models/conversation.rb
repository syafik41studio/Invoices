class Conversation < ActiveRecord::Base

  has_and_belongs_to_many :users
  has_many :messages, :class_name => "MessageConversation"

  attr_accessible :recipient_tokens, :body, :owner_id
  attr_accessor :recipient_tokens, :body, :owner_id

  validates :recipient_tokens, :presence => true
  validates :body, :presence => true

  def self.build_conversation(param)
    conversation = Conversation.new(param)
    p "------asdasdasd----------------"
    p conversation.list_member_conversation
    p "----------------------------------"
    members = conversation.list_member_conversation
    if members.size.eql?(2)
      exist_conversation = Conversation.includes(:users).where("users.id = ?", members.last).first
      unless exist_conversation.blank?
        exist_conversation.recipient_tokens = param[:recipient_tokens]
        exist_conversation.owner_id = param[:owner_id]
        exist_conversation.body = param[:body]
        exist_conversation.build_message_conversation_for_each_member
        return exist_conversation
      else
        conversation.save_member_for_new_conversation
        conversation.build_message_conversation_for_each_member
        return conversation
      end
    else
      conversation.save_member_for_new_conversation
      conversation.build_message_conversation_for_each_member
      return conversation
    end
  end

  def list_member_conversation
    self.recipient_tokens.split(",").unshift(self.owner_id)
  end

  def build_message_conversation_for_each_member
    members = self.list_member_conversation.shift(1)
    p "--------------members----------"
    p members
    p "------------"
    members.each do |member|
      self.messages.push(
        MessageConversation.new(:sender_id => self.owner_id,
          :recipient_id => member, :body => self.body ))
    end
  end

  def save_member_for_new_conversation
    members = self.list_member_conversation
    members.each do |member|
      self.users.push(User.find(member))
    end
  end

end
