class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :speciality
      t.string :gender
      t.string :languages
      t.string :accepting_new_patient
      t.text :about_me
      t.text :biography
      t.text :practice
      t.text :training_and_cert
      t.string :work_phone
      t.string :ext
      t.string :work_cell_phone
      t.string :work_fax_number
      t.string :email_address
      t.string :office_address
      t.string :office_address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :working_hours
      t.string :prefered_contact_method
      t.boolean :speciality_pv, :default => false
      t.boolean :gender_pv, :default => false
      t.boolean :languages_pv, :default => false
      t.boolean :accepting_new_patient_pv, :default => false
      t.boolean :about_me_pv, :default => false
      t.boolean :biography_pv, :default => false
      t.boolean :practice_pv, :default => false
      t.boolean :training_and_cert_pv, :default => false
      t.boolean :work_phone_pv, :default => false
      t.boolean :ext_pv, :default => false
      t.boolean :work_cell_phone_pv, :default => false
      t.boolean :work_fax_number_pv, :default => false
      t.boolean :email_address_pv, :default => false
      t.boolean :office_address_pv, :default => false
      t.boolean :office_addresss_2_pv, :default => false
      t.boolean :city_pv, :default => false
      t.boolean :state_pv, :default => false
      t.boolean :zip_pv, :default => false
      t.boolean :working_hours_pv, :default => false
      t.boolean :prefered_contact_method_pv, :default => false
      t.boolean :holiday_observed_pv, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
