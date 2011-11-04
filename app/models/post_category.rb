class PostCategory < ActiveRecord::Base

  validates :name, :presence => true
  
  has_many :children, :class_name => "PostCategory", :foreign_key => 'parent_id'
  belongs_to :parent, :class_name => "PostCategory", :foreign_key => 'parent_id'

  default_scope order("created_at ASC")
  
  scope :mine, lambda{|user|
    includes(:children).
    where("user_id = ?", user.id)
  }
  scope :root, where("parent_id IS NULL")

  def is_root?
    self.parent_id.eql?(nil)
  end
end
