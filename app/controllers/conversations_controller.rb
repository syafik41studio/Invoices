class ConversationsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @conversations = Conversation.includes(:users, :messages).
      where("users.id = ?",1).
      order("conversations.updated_at DESC")
  end
  
end
