class BillingEntity < ActiveRecord::Base
  # == Schema Information
#
# Table name: billing_entities
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  branch            :string(255)
#  entity_type       :string(255)
#  active            :boolean
#  billing_format    :string(255)
#  clearing_house    :string(255)
#  departement       :string(255)
#  attn              :string(255)
#  address_line_1    :string(255)
#  address_line_2    :string(255)
#  city              :string(255)
#  state             :string(255)
#  zip               :string(255)
#  phone             :string(255)
#  fax               :string(255)
#  other_info_1      :string(255)
#  other_info_2      :string(255)
#  other_info_3      :string(255)
#  other_info_4      :string(255)
#  comment           :text
#  invoice_id        :integer
#  insurance_plan    :string(255)
#  mediacare         :boolean
#  mediacaid         :boolean
#  tricare           :boolean
#  champva           :boolean
#  healt_plan        :boolean
#  black_ling        :boolean
#  other             :boolean
#  accept_assignment :boolean
#  created_at        :datetime
#  updated_at        :datetime
#


  belongs_to :invoice
end

