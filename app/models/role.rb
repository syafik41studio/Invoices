class Role < ActiveRecord::Base


# == Schema Information
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#



	has_and_belongs_to_many :users
end
