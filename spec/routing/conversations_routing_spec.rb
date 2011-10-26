require "spec_helper"

describe PostsController do
  describe "routing" do

    it "routes to #index" do
      get("/conversations").should route_to("conversations#index")
    end

    it "routes to #new" do
      get("/conversations/new").should route_to("conversations#new")
    end

    it "routes to #show" do
      get("/conversations/1").should route_to("conversations#show", :id => "1")
    end

    it "routes to #create" do
      post("/conversations").should route_to("conversations#create")
    end
    
    it "routes to #user_token_input" do
      get("/user_token_input").should route_to("conversations#user_token_input")
    end
    
    it "routes to #search_conversations_by_name" do
      post("/search_conversations_by_name").should route_to("conversations#search_conversations_by_name")
    end

    it "routes to #notifications" do
      get("/conversations/notifications").should route_to("conversations#notifications")
    end
    
    it "routes to #mark_as_read" do
      get("/conversations/1/mark_as_read").should route_to("conversations#mark_as_read", :id => "1")
    end

    it "routes to #mark_as_unread" do
      get("/conversations/1/mark_as_unread").should route_to("conversations#mark_as_unread", :id => "1")
    end
    
    it "routes to #archive" do
      get("/conversations/1/archive").should route_to("conversations#archive", :id => "1")
    end
  
    it "routes to #search" do
      post("/conversations/1/search").should route_to("conversations#search", :id => "1")
    end

  end
end
