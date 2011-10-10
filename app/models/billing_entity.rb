class BillingEntity < ActiveRecord::Base
  belongs_to :invoice
end
