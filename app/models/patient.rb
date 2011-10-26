class Patient < ActiveRecord::Base
  
# == Schema Information
#
# Table name: patients
#
#  id                  :integer         not null, primary key
#  user_id             :integer
#  name                :string(255)
#  age                 :float
#  description         :text
#  visits              :string(255)
#  primary_contact     :string(255)
#  relation            :string(255)
#  email               :string(255)
#  phone_number        :string(255)
#  city                :string(255)
#  state               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#



  paginates_per 1
  has_attached_file :avatar, :styles => {:thumb => ["50x50#", :png] }
  validates :name, :presence => true
  validates :age, :presence => true, :inclusion => { :in => 0..9 }
  validates :description, :presence => true
  validates :visits, :presence => true
  validates :primary_contact, :presence => true
  validates :relation, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
end
