class ConversationsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @conversations = Conversation.with_status(current_user, params[:query] || "read_unread").recent
  end

  def new
    @conversation = Conversation.new
    @users = []
    respond_to do |format|
      format.js
    end
  end

  def user_token_input
    @users = User.by_name(params[:q]).not_me(current_user)
    respond_to do |format|
      format.html
      format.json { render :json => @users.map{|user| user.attributes.merge(:full_name => user.full_name) } }
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

  def show
    @conversation = Conversation.find(params[:id])
    @messages =  MessageConversation.included_me(@conversation, current_user)
    @messages = @messages.sort {|x,y| x.created_at <=> y.created_at }
    @conversation.mark_as_read(current_user) unless @conversation.is_archive?(current_user)
    @search = SearchCriteria.new
  end

  def update
    @conversation = Conversation.find(params[:id])
    @conversation.update_conversation_with_reply(params[:conversation])
    @message = @conversation.last_message
  end

  def notifications
    @inbox = Conversation.my_inbox(current_user)
    respond_to do |format|
      format.js {@inbox.to_json}
    end
  end

  def mark_as_read
    @conversation = Conversation.find(params[:id])
    @conversation.mark_as_read(current_user)
    respond_to do |format|
      format.js{}
      format.html{redirect_to conversations_path}
    end
  end

  def mark_as_unread
    @conversation = Conversation.find(params[:id])
    @conversation.mark_as_unread(current_user)
    respond_to do |format|
      format.js{}
      format.html{redirect_to conversations_path}
    end
  end

  def archive
    @conversation = Conversation.find(params[:id])
    @conversation.mark_as_archive(current_user)
    respond_to do |format|
      format.js{}
      format.html{redirect_to conversations_path}
    end
  end

  def unarchive
    @conversation = Conversation.find(params[:id])
    @conversation.mark_as_unarchive(current_user)
    respond_to do |format|
      format.js{}
      format.html{redirect_to conversations_path}
    end
  end

  def search_conversations_by_name
    @conversation_flags = ConversationFlag.by_name(params[:q], current_user).not_archived
    @conversation_flags = @conversation_flags.select{|c| c.conversation.users.include?(current_user)}
    respond_to do |format|
      format.html
      format.json {
        render :json => @conversation_flags.map{|conv|
          conv.conversation.attributes.merge({:title => conversation_title(conv.conversation), :last_message => conv.conversation.messages.last.body})
        }
      }
    end  
  end

  def search
    @search = SearchCriteria.new(params[:search])
    @conversation = Conversation.find(@search.conversation_id)
    @messages =  MessageConversation.included_me(@conversation, current_user).with_body_criteria(@search.body)
    @messages = @messages.sort {|x,y| x.created_at <=> y.created_at }
    @conversation.mark_as_read(current_user)
  end

  
end
