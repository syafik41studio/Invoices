class Follower < ActiveRecord::Base

  belongs_to :follower_user, :class_name => "User", :foreign_key => "follower_id"
  belongs_to :following_user, :class_name => "User", :foreign_key => "following_id"
  
  default_scope order("followers.created_at DESC")
end
