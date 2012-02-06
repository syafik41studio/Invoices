class UsersController < ApplicationController

  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @posts = @user.posts.page params[:page]
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    redirect_to root_path, :notice => "user has been successfully updated."
  end

  def edit_profile
    @user = User.find(params[:id])
    @user_profile = @user.profile || Profile.new
    @user_profile.full_name = @user.full_name
    @user_profile.user_id = @user.id
    @redirect = @user_profile.new_record? ? create_profile_users_path : update_profile_user_path(@user_profile)
  end

  def create_profile
    @user = User.find(params[:profile][:user_id])
    @user_profile = Profile.new(params[:profile])
    @redirect = create_profile_users_path 
    if @user_profile.save
      redirect_to user_path(@user), :notice => "Changes to your profile have been saved successfully."
    else
      render :edit_profile
    end
  end

  def update_profile
    @user = User.find(params[:profile][:user_id])
    @user_profile = @user.profile
    @redirect = update_profile_user_path(@user_profile)
    if @user_profile.update_attributes(params[:profile])
      redirect_to user_path(@user), :notice => "Changes to your profile have been saved successfully."
    else
      render :edit_profile
    end
  end

  def send_message
    @conversation = Conversation.new
    @user = User.find(params[:id])
    render :layout => false
  end

  def load_profile
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def load_posts
    @user = User.find(params[:id])
    @posts = @user.posts.page params[:page]
  end

  def follow
    @user = User.find(params[:id])
    follower_user = current_user
    Follower.create(
      :following_user => @user,
      :follower_user => follower_user
    )
  end

  def unfollow
    @user = User.find(params[:id])
    follow = Follower.where("following_id = ? and follower_id = ?", @user.id, current_user.id).first
    follow.destroy
  end

  def load_all_follower
    @user = User.find(params[:id])
    @followers = @user.followers.includes(:follower_user => :profile)
  end
  
  def load_all_following
    @user = User.find(params[:id])
    @followings = @user.followings.includes(:following_user => :profile)
  end

  
end
