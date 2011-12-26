class HolidayObserved < ActiveRecord::Base

  belongs_to :profile

  attr_accessor :simple_date
  attr_accessible :simple_date
  
end
