class Conversation < ActiveRecord::Base
  require 'digest'
  
  has_and_belongs_to_many :users
  has_many :messages, :class_name => "MessageConversation"
  has_one :conversation_flag
       
  attr_accessible :recipient_tokens, :body, :owner_id, :last_message
  attr_accessor :recipient_tokens, :body, :owner_id, :last_message

  validates :recipient_tokens, :presence => true
  validates :body, :presence => true

  scope :by_name, lambda{|name|
    includes(:users, :messages).where("(users.first_name||' '||users.last_name) ILIKE ?", "%#{name}%")
  }

  scope :include_me, lambda{|user|
    includes(:users).where("users.id = ?", user.id)
  }

  scope :my_inbox, lambda{ |user|
    includes(:conversation_flag, :messages, :users)
    where("(conversation_flag.status = ? AND users.id = ?) OR messages.status_for_recipient = ?", user.id, 'Unread', 'Unread')
  }

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
        exist_conversation.set_status_to_unread
        exist_conversation.updated_at = Time.now
        return exist_conversation
      else
        conversation.updated_at = Time.now
        conversation.save_member_for_new_conversation
        conversation.build_message_conversation_for_each_member
        conversation.set_status_to_unread
        return conversation
      end
    else
      conversation.updated_at = Time.now
      conversation.save_member_for_new_conversation
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
      self.conversation_flag.update_attribute(:status, "Unread")
    else
      self.conversation_flag = ConversationFlag.new(
        :user_id => self.owner_id,
        :status => "Unread"
      )
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
    @unread ||= ConversationFlag.where("conversation_id = ? AND user_id = ?", self.id, user.id).first.status.eql?("Unread") rescue false
  end

end
