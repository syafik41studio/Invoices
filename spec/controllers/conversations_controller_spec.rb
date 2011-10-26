require 'spec_helper'

describe ConversationsController do
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

    sign_in @user_sender
  end
  
  describe "GET index" do
    it "assigns all conversations as @conversations" do
      @conversation.save
      get :index
      assigns(:conversations).should eq([@conversation])
    end

    it "should render template index" do
      get :index
      response.should render_template("index")
    end
  end

  describe "GET new" do
    it "assign new conversation as @conversation" do
      get :new
      assigns(:conversation).should be_a_new(Conversation)
    end

    it "assign users as @users" do
      get :new
      assigns(:users).should eq([])
    end

  end

  describe "POST create" do
    it "should create new conversation as @conversation" do
      post :create, :conversation => {
        :recipient_tokens => "#{@user_recipient.id}",
        :owner_id => "#{@user_sender.id}",
        :body => "Test Message"
      }
      assigns(:conversation).should be_a(Conversation)
      assigns(:conversation).should be_persisted
    end
  end

  describe "GET show" do
    it "should assign requested conversation as @conversation" do
      @conversation.save
      get :show, :id => @conversation.id
      assigns(:conversation).should eq(@conversation)
    end

    it "should assign messages as @messages" do
      @conversation.save
      get :show, :id => @conversation.id
      assigns(:messages).should include(@conversation.messages.first)
    end

    it "should assigns search as @search" do
      @conversation.save
      get :show, :id => @conversation.id
      assigns(:search).should be_a(SearchCriteria)
    end
  end

  describe "PUT update" do
    it "should render template update.js" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      @conversation.save
      put :update, :id => @conversation.id, :conversation => {
        :recipient_tokens => "#{@user_recipient.id}",
        :owner_id => "#{@user_sender.id}",
        :body => "Test Message 2"
      }
      response.should render_template("update")
    end

    it "should assign conversation as @conversation" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      @conversation.save
      put :update, :id => @conversation.id, :conversation => {
        :recipient_tokens => "#{@user_recipient.id}",
        :owner_id => "#{@user_sender.id}",
        :body => "Test Message 2"
      }
      assigns(:conversation).should eq(@conversation)
    end
  end

  describe "GET notification" do
    it "should render template notifications" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      get :notifications
      response.should render_template("notifications")
    end
  end

  describe "GET mark as read" do
    it "should assign conversation requested as @conversation" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      @conversation.save
      get :mark_as_read, :id => @conversation.id
      assigns(:conversation).should eq(@conversation)
    end
    
    it "should render template mark_as_read" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      @conversation.save
      get :mark_as_read, :id => @conversation.id
      response.should render_template("mark_as_read")
    end
  end
  
  describe "GET mark as unread" do
    it "should assign conversation requested as @conversation" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      @conversation.save
      get :mark_as_read, :id => @conversation.id
      assigns(:conversation).should eq(@conversation)
    end

    it "should render template mark_as_unread" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      @conversation.save
      get :mark_as_unread, :id => @conversation.id
      response.should render_template("mark_as_unread")
    end
  end
  
  describe "GET archive" do
    it "should assign conversation requested as @conversation" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      @conversation.save
      get :archive, :id => @conversation.id
      assigns(:conversation).should eq(@conversation)
    end

    it "should render template mark_as_unread" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      @conversation.save
      get :archive, :id => @conversation.id
      response.should render_template("archive")
    end
  end
  
end
