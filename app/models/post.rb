class Post < ActiveRecord::Base

  paginates_per 10
   
  acts_as_commentable
  acts_as_taggable
  belongs_to :user

  has_and_belongs_to_many :post_categories, :join_table => "posts_with_categories", :association_foreign_key => "category_id"
  
  validates :title, :presence => true

  scope :published, where("status = ?", 'Publish')
  scope :unpublished, where("published != ?", 'Publish')
  scope :mine, lambda{|user|
    where("user_id = ?", user.id)
  }

  default_scope order("posts.created_at DESC")
  
  extend FriendlyId
  friendly_id :title, :use => :slugged

  def is_published?
    self.status.eql?("Publish")
  end

  # == Schema Information
  #
  # Table name: posts
  #
  #  id             :integer         not null, primary key
  #  user_id        :integer
  #  title          :string(255)
  #  description    :text
  #  status         :string(255)
  #  total_comment  :integer
  #  last_commented :datetime
  #  created_at     :datetime
  #  updated_at     :datetime
  #
end
