class Post < ActiveRecord::Base


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


  belongs_to :user
end
