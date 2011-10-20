class ConversationsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @conversations = Conversation.includes(:users, :messages).
      where("users.id = ?",current_user.id).
      order("conversations.updated_at DESC")
  end

  def new
    @conversation = Conversation.new
    @users = []
    respond_to do |format|
      format.js
    end
  end

  def user_token_input
    @users = User.where("email like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @users.map(&:attributes) }
    end  
  end

  def create
    @conversation = Conversation.build_conversation(params[:conversation])
    if @conversation.save
      render :update do |page|
        page.redirect_to conversation_path(@conversation)
      end
    end
  end
  
end
