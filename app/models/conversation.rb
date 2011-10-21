class Conversation < ActiveRecord::Base
  require 'digest'
  
  has_and_belongs_to_many :users
  has_many :messages, :class_name => "MessageConversation"

  attr_accessible :recipient_tokens, :body, :owner_id, :last_message
  attr_accessor :recipient_tokens, :body, :owner_id, :last_message

  validates :recipient_tokens, :presence => true
  validates :body, :presence => true

  def self.build_conversation(param)
    conversation = Conversation.new(param)
    members = conversation.list_member_conversation
    if members.size.eql?(2)
      exist_conversation = Conversation.includes(:users).where("users.id = ?", members.last).first
      unless exist_conversation.blank?
        exist_conversation.recipient_tokens = param[:recipient_tokens]
        exist_conversation.owner_id = param[:owner_id]
        exist_conversation.body = param[:body]
        exist_conversation.build_message_conversation_for_each_member
        exist_conversation.updated_at = Time.now
        return exist_conversation
      else
        conversation.updated_at = Time.now
        conversation.save_member_for_new_conversation
        conversation.build_message_conversation_for_each_member
        return conversation
      end
    else
      conversation.updated_at = Time.now
      conversation.save_member_for_new_conversation
      conversation.build_message_conversation_for_each_member
      return conversation
    end
  end

  def update_conversation_with_reply(param)
    conversation = self
    conversation.recipient_tokens = param[:recipient_tokens]
    conversation.owner_id = param[:owner_id]
    conversation.body = param[:body]
    conversation.build_message_conversation_for_each_member
    conversation.updated_at = Time.now
    conversation.save
  end

  def list_member_conversation
    self.recipient_tokens.split(",").unshift(self.owner_id)
  end

  def build_message_conversation_for_each_member
    members = self.list_member_conversation
    token = Digest::SHA1.hexdigest("#{members.to_s}-#{Time.now}")
    members.delete(self.owner_id)
    members.each do |member|
      self.last_message =  MessageConversation.new(:sender_id => self.owner_id,
        :recipient_id => member, :body => self.body, :message_token => token )
      self.messages.push(self.last_message)
    end
  end

  def save_member_for_new_conversation
    members = self.list_member_conversation
    members.each do |member|
      self.users.push(User.find(member))
    end
  end

  def unread_messages(user)
    @unread = self.messages.where("status_for_recipient = ? AND recipient_id = ?", 'Unread', user.id )
  end
  
  def have_unread_message?(user)
    @have_inbox ||= !self.unread_messages(user).blank?
  end

  def mark_as_read(user)
    MessageConversation.update_all("status_for_recipient = 'Read'",
      "conversation_id = #{self.id} AND status_for_recipient = 'Unread' AND recipient_id = #{user.id}")
  end

  def mark_as_unread(user)
    MessageConversation.update_all("status_for_recipient = 'Unread'",
      "conversation_id = #{self.id} AND status_for_recipient = 'Read' AND id = #{self.messages.last.id} AND recipient_id = #{user.id}")
  end

  def is_unread?
    self.status.eql?("Unread")
  end

  def is_read?
    self.status.eql?("Read")
  end

  def is_archive?
    self.status.eql?("Archive")
  end

end
