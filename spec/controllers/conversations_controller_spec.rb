require 'spec_helper'

describe ConversationsController do
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

    sign_in @user_contacts
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
        :recipient_tokens => "#{@user_provider.id}",
        :owner_id => "#{@user_contacts.id}",
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
        :recipient_tokens => "#{@user_provider.id}",
        :owner_id => "#{@user_contacts.id}",
        :body => "Test Message 2"
      }
      response.should render_template("update")
    end

    it "should assign conversation as @conversation" do
      request.env["HTTP_ACCEPT"] = "application/javascript"
      @conversation.save
      put :update, :id => @conversation.id, :conversation => {
        :recipient_tokens => "#{@user_provider.id}",
        :owner_id => "#{@user_contacts.id}",
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
