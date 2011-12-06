require 'spec_helper'

describe MessageConversation do
  before(:each) do
    @provider_role = Role.create(:name => "Provider")
    @contacts_role = Role.create(:name => "Contacts")
    @general_role = Role.create(:name => "General User")

    @user_provider = Factory.create(:user, {
        :email => "john@example.com",
        :first_name => "John",
        :last_name => "Doe",
        :roles => [@provider_role]
      })

    @user_contacts = Factory.create(:user, {
        :email => "melinda@example.com",
        :first_name => "Melinda",
        :last_name => "Dee",
        :roles => [@contacts_role]
      })

    @user_general = Factory.create(:user, {
        :email => "kim@example.com",
        :first_name => "Kimberly",
        :last_name => "McLeod",
        :roles => [@general_role]
      })

    @conversation = Conversation.build_conversation(
      :recipient_tokens => "#{@user_provider.id}",
      :owner_id => "#{@user_contacts.id}",
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
    @conversation.messages.first.sender.should == @user_contacts
  end

  it "should user_recipient as recipient" do
    @conversation.save
    @conversation.messages.first.recipient.should == @user_provider
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
    @conversation.mark_as_read(@user_provider)
    @conversation.messages.where("recipient_id = ?", @user_provider).first.status_for_recipient.should == "Read"
  end

  it "should have Unread status message when mark as unread" do
    @conversation.save
    @conversation.mark_as_unread(@user_provider)
    @conversation.messages.where("recipient_id = ?", @user_provider).first.status_for_recipient.should == "Unread"
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

