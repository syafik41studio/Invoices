class Profile < ActiveRecord::Base

  belongs_to :user
  has_many :holiday_observeds

  accepts_nested_attributes_for :holiday_observeds, :reject_if => :all_blank, :allow_destroy => true
  
  attr_accessor :full_name
  attr_accessible :full_name, :user_id, :speciality, :gender, :languages, :accepting_new_patient,
    :about_me, :biography, :practice, :training_and_cert, :work_phone, :ext, :work_cell_phone,
    :work_fax_number, :email_address, :office_address, :office_address_2, :city, :state,
    :zip, :working_hours, :prefered_contact_method, :speciality_pv, :gender_pv, :languages_pv,
    :accepting_new_patient_pv, :about_me_pv, :biography_pv, :practice_pv, :training_and_cert_pv,
    :work_phone_pv, :ext_pv, :work_cell_phone_pv, :work_fax_number_pv, :email_address_pv,
    :office_address_pv, :office_addresss_2_pv, :city_pv,:state_pv, :zip_pv, :working_hours_pv,
    :prefered_contact_method_pv, :holiday_observed_pv, :description, :description_pv, :holiday_observeds_attributes

  after_save :set_user_full_name

  def set_user_full_name
    arr_name = self.full_name.split(" ")
    first_name = arr_name.first
    last_name = arr_name[1..arr_name.size].join(" ")
    self.user.first_name = first_name
    self.user.last_name = last_name
    self.user.save
  end

end
