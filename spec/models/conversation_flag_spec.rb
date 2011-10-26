require 'spec_helper'

describe ConversationFlag do
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
    ConversationFlag.new.should be_an_instance_of(ConversationFlag)
  end

  it "can be saved successfully" do
    @conversation.save
    @conversation.conversation_flags.first.should be_persisted
  end

  it "can't be saved successfully" do
    @conversation.recipient_tokens = nil
    @conversation.save
    @conversation.conversation_flags.first.should_not be_persisted
  end

  it "should have Unread status for recipient " do
    @conversation.save
    @conversation.conversation_flags.where("user_id = ?", @user_recipient.id).first.status.should == "Unread"
  end
  
  it "should have Unread status for sender" do
    @conversation.save
    @conversation.conversation_flags.where("user_id = ?", @user_sender.id).first.status.should == "Unread"
  end

end
