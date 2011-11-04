class Post < ActiveRecord::Base

  acts_as_commentable
  acts_as_taggable
  belongs_to :user

  has_and_belongs_to_many :post_categories, :join_table => "posts_with_categories", :association_foreign_key => "category_id"

  validates :title, :presence => true

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
