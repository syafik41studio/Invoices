require 'spec_helper'

describe Patient do
  pending "add some examples to (or delete) #{__FILE__}"
end

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

