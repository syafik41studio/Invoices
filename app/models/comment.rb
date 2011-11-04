class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at DESC'

  after_create :set_comment_count_and_last_comment_for_post

  validates :title, :comment, :presence => true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  def set_comment_count_and_last_comment_for_post
    post = self.commentable
    post.total_comment = post.comments.count
    post.last_commented = self.created_at
    post.save
  end
end
