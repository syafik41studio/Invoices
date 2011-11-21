class PostsController < ApplicationController  

  before_filter :authenticate_user!, :except => [:index, :show, :load_query_type]
  authorize_resource

  def index
    @posts = do_with_search

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    respond_to do |format|
      if @post.save
        format.html { redirect_to(mine_posts_path, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(mine_posts_path, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  def create_comment
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to post_path(@comment.commentable), :notice => "Comment successfully created."
    else
      render :action => :show
    end
  end

  def mine
    @posts = Post.mine(current_user).page params[:page]
  end

  def load_query_type
    @type = params[:type]
    render :layout => false
  end

  def like
    @post = Post.find(params[:id])
    @like = Like.create(:user => current_user, :likeable => @post)
    respond_to do |format|
      format.js{}
      format.html{redirect_to posts_path}
    end
  end

  def unlike
    @post = Post.find(params[:id])
    @like = Like.where("user_id = ? AND likeable_type = ? AND likeable_id = ? ", current_user.id, @post.class.to_s, @post.id).first
    @like.destroy
    respond_to do |format|
      format.js{}
      format.html{redirect_to posts_path}
    end
  end

  private

  def do_with_search
    if params[:type].blank?
      Post.includes(:user, :comments, :likes).published.page params[:page]
    else
      case params[:type]
      when "Author"
        Post.includes(:user, :comments, :likes).published.where("(users.first_name||' '|| users.last_name) ILIKE ?", "%#{params[:query_field1]}%").page params[:page]
      when "Text"
        Post.includes(:user, :comments, :likes).published.where("description ILIKE ?", "%#{params[:query_field1]}%").page params[:page]
      when "Date"
        from_date = params[:query_field1]
        to_date = params[:query_field2]
        Post.includes(:user, :comments, :likes).published.where("to_char(posts.created_at AT TIME ZONE 'UTC#{session[:tz]}', 'yyyy-mm-dd') between ? and ?", from_date, to_date).page params[:page]
      when "Tag"
        tags = params[:query_field1].split(",")
        tags = tags.blank? ? "" : tags
        Post.tagged_with(tags, :any => true).includes(:user, :comments, :likes).published.page params[:page]
      when "Category"
        Post.includes(:post_categories, :user, :comments).where("post_categories.name ILIKE ?", "%#{params[:query_field1]}%").published.page params[:page]
      end
    end
  end

end
