class Like < ActiveRecord::Base

  after_save :do_total_like_in_post
  
  belongs_to :likeable, :polymorphic => true
  belongs_to :user

  def do_total_like_in_post
    post = self.likeable
    post.update_attribute(:total_like, (post.total_like || 0) + 1)
  end
  
end
