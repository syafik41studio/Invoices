class Conversation < ActiveRecord::Base
  require 'digest'

  has_many :messages, :class_name => "MessageConversation"
  has_many :conversation_flags
  has_many :users, :through => :conversation_flags
       
  attr_accessible :recipient_tokens, :body, :owner_id, :last_message
  attr_accessor :recipient_tokens, :body, :owner_id, :last_message

  validates :recipient_tokens, :presence => true
  validates :body, :presence => true

  scope :my_inbox, lambda{ |user|
    includes(:conversation_flags, :messages).
      where("(message_conversations.status_for_recipient = ? AND message_conversations.recipient_id = ?)
         OR (conversation_flags.status = ? AND conversation_flags.user_id = ?)", 'Unread', user.id, 'Unread', user.id)
  }

  scope :my, lambda{|user|
    includes(:users, :conversation_flags).
      where("users.id = ? AND conversation_flags.status <> ? AND conversation_flags.user_id = ?", user.id, "Archive", user.id)
  }

  scope :recent, order("conversations.updated_at DESC")

  def self.build_conversation(param)
    conversation = Conversation.new(param)
    members = conversation.list_member_conversation
    if members.size.eql?(2)
      conversations = Conversation.includes(:users).where("conversations.member_count = ? AND users.id IN (?)", 2, members)
      exist_conversation = conversations.select{|c| c.users.map(&:id).include?(members.first.to_i) && c.users.map(&:id).include?(members.last.to_i)}.first
      unless exist_conversation.blank?
        exist_conversation.recipient_tokens = param[:recipient_tokens]
        exist_conversation.owner_id = param[:owner_id]
        exist_conversation.body = param[:body]
        exist_conversation.build_message_conversation_for_each_member
        exist_conversation.set_status_to_unread
        exist_conversation.updated_at = Time.now
        return exist_conversation
      else
        conversation.member_count = members.count
        conversation.updated_at = Time.now
        conversation.build_message_conversation_for_each_member
        conversation.set_status_to_unread
        return conversation
      end
    else
      conversation.member_count = members.count
      conversation.updated_at = Time.now
      conversation.build_message_conversation_for_each_member
      conversation.set_status_to_unread
      return conversation
    end
  end

  def update_conversation_with_reply(param)
    conversation = self
    conversation.recipient_tokens = param[:recipient_tokens]
    conversation.owner_id = param[:owner_id]
    conversation.body = param[:body]
    conversation.build_message_conversation_for_each_member
    conversation.set_status_to_unread
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

  def set_status_to_unread
    if self.persisted?
      members = self.users.map(&:id)
      members.delete(self.owner_id.to_i)
      #      ConversationFlag.update_all("status = 'Unread'", ["conversation_id = #{self.id} AND user_id IN (#{members.join(',')})"])
      ConversationFlag.update_all("status = 'Unread'", ["conversation_id = ? AND user_id IN (?)", self.id, members])
    else
      members = self.list_member_conversation
      members.each do |member|
        self.conversation_flags.push(ConversationFlag.new(
            :user_id => member,
            :status => "Unread"
          ))
      end
    end
  end

  def unread_messages(user)
    @unread_messages ||= self.messages.where("status_for_recipient = ? AND recipient_id = ?", 'Unread', user.id )
  end

  def inbox(user)
    @inbox ||= self.messages.where("recipient_id = ?", user.id )
  end
  
  def have_unread_message?(user)
    @have_unread_message ||= !self.unread_messages(user).blank?
  end

  def contains_inbox(user)
    @contains ||= !self.inbox(user).blank?
  end

  def mark_as_read(user)
    MessageConversation.update_all("status_for_recipient = 'Read'",
      "conversation_id = #{self.id} AND recipient_id = #{user.id}")
    ConversationFlag.update_all("status = 'Read'", "conversation_id = #{self.id} AND user_id = #{user.id}")
  end

  def mark_as_unread(user)
    MessageConversation.update_all("status_for_recipient = 'Unread'",
      "conversation_id = #{self.id} AND id = #{self.messages.last.id} AND recipient_id = #{user.id}")
    ConversationFlag.update_all("status = 'Unread'", "conversation_id = #{self.id} AND user_id = #{user.id}")
  end

  def mark_as_archive(user)
    MessageConversation.update_all("status_for_recipient = 'Read'",
      "conversation_id = #{self.id} AND id = #{self.messages.last.id} AND recipient_id = #{user.id}")
    ConversationFlag.update_all("status = 'Archive'", "conversation_id = #{self.id} AND user_id = #{user.id}")
  end

  def last_message_from_sender_to_recipient(sender, recipient)
    self.messages.where("sender_id = ? AND recipient_id = ?", sender.id, recipient.id).last
  end

  def is_unread?(user)
    @unread ||= ConversationFlag.where("conversation_id = ? AND user_id = ?", self.id, user.id).first.status.eql?("Unread")
  end

end
