class UsersController < ApplicationController

  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @profile = @user.profile
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
    @profile = Profile.new(params[:profile])
    @redirect = create_profile_users_path 
    if @profile.save
      redirect_to user_path(@user), :notice => "user profile has been successfully updated."
    else
      render :edit_profile
    end
  end

  def update_profile
    @user = User.find(params[:profile][:user_id])
    @profile = @user.profile
    @redirect = update_profile_user_path(@profile)
    @profile.attributes = params[:profile]
    if @profile.save
      redirect_to user_path(@user), :notice => "user profile has been successfully updated."
    else
      render :edit_profile
    end
  end
  
end
