class HolidayObserved < ActiveRecord::Base

  belongs_to :profile

  attr_accessor :simple_date
  attr_accessible :simple_date, :holiday_date, :holiday_name, :holiday_description
  
end
