class Invoice < ActiveRecord::Base

# == Schema Information
#
# Table name: invoices
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

  has_many :billing_entities
end
