class Invoice < ActiveRecord::Base
  has_many :billing_entities
end
