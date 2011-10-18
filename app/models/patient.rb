class Patient < ActiveRecord::Base
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
