class Post < ActiveRecord::Base

  acts_as_commentable
  belongs_to :user
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
