require 'spec_helper'

describe MessageConversation do
  before(:each) do
    @user_admin = Factory.create(:user)
    @user_recipient = Factory.create(:user, {
        :email => "recipient@email.com",
        :first_name => "Recipient",
        :last_name => "Recipient"
      })
    @user_sender = Factory.create(:user, {
        :email => "sender@email.com",
        :first_name => "Sender",
        :last_name => "Sender"
      })
    @conversation = Conversation.build_conversation(
      :recipient_tokens => "#{@user_recipient.id}",
      :owner_id => "#{@user_sender.id}",
      :body => "Test Message"
    )
  end


  it "can be instantiated" do
    MessageConversation.new.should be_an_instance_of(MessageConversation)
  end

  it "can be saved successfully" do
    @conversation.save
    @conversation.messages.first.should be_persisted
  end

  it "can't be saved successfully" do
    @conversation.recipient_tokens = nil
    @conversation.save
    @conversation.messages.first.should_not be_persisted
  end

  it "should user_sender as sender" do
    @conversation.save
    @conversation.messages.first.sender.should == @user_sender
  end

  it "should user_recipient as recipient" do
    @conversation.save
    @conversation.messages.first.recipient.should == @user_recipient
  end

  it "should have Unread status message for recipient" do
    @conversation.save
    @conversation.messages.first.status_for_recipient.should == "Unread"
  end
  
  it "should have Sent status message for sender" do
    @conversation.save
    @conversation.messages.first.status_for_sender.should == "Sent"
  end

  it "should have Read status message when user read" do
    @conversation.save
    @conversation.mark_as_read(@user_recipient)
    @conversation.messages.where("recipient_id = ?", @user_recipient).first.status_for_recipient.should == "Read"
  end

  it "should have Unread status message when mark as unread" do
    @conversation.save
    @conversation.mark_as_unread(@user_recipient)
    @conversation.messages.where("recipient_id = ?", @user_recipient).first.status_for_recipient.should == "Unread"
  end


end

# == Schema Information
#
# Table name: message_conversations
#
#  id                   :integer         not null, primary key
#  conversation_id      :integer         not null
#  sender_id            :integer         not null
#  recipient_id         :integer         not null
#  body                 :text            not null
#  status_for_sender    :string(255)
#  status_for_recipient :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  message_token        :string(255)
#

