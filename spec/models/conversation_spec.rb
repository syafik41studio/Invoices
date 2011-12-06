require 'spec_helper'

describe Conversation do
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
    Conversation.new.should be_an_instance_of(Conversation)
  end
  
  it "can be saved successfully" do
    @conversation.save
    @conversation.should be_persisted
  end

  it "can't be saved successfully" do
    @conversation.recipient_tokens = nil
    @conversation.save
    @conversation.errors.should_not == []

  end
  
  it "can't be saved successfully with error on recipient tokens" do
    @conversation.recipient_tokens = nil
    @conversation.save
    @conversation.should have(1).error_on(:recipient_tokens)

  end

  it "can't be saved successfully with error can't be blank on recipient tokens" do
    @conversation.recipient_tokens = nil
    @conversation.save
    @conversation.errors[:recipient_tokens].should == ["can't be blank"]
  end
  
  it "can't be saved successfully with error on body" do
    @conversation.body = nil
    @conversation.save
    @conversation.should have(1).error_on(:body)

  end

  it "can't be saved successfully with error can't be blank on body" do
    @conversation.body = nil
    @conversation.save
    @conversation.errors[:body].should == ["can't be blank"]
  end

  it "should have member of conversation" do
    @conversation.list_member_conversation.should == ["#{@user_contacts.id}","#{@user_provider.id}"]
  end

  it "should have messages on conversations" do
    @conversation.save
    @conversation.messages.should_not == []
  end

  it "should have 1 messages on conversations" do
    @conversation.save
    @conversation.messages.count.should == 1
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

  it "should have inbox messages for recipient" do
    @conversation.save
    inbox = @conversation.inbox(@user_provider)
    inbox.should_not == []
  end
  
  it "should have unread message" do
    @conversation.save
    have = @conversation.have_unread_message?(@user_provider)
    have.should == true
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
# Table name: conversations
#
#  id           :integer         not null, primary key
#  member_count :integer
#  created_at   :datetime
#  updated_at   :datetime
#

