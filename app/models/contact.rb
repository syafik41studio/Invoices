class Contact < ActiveRecord::Base
  belongs_to :entity, :polymorphic => true
  has_attached_file :photo, :styles => { :thumb => "100x100>" }, :default_style => :thumb
  # todo: add associations

  before_validation :sanitize_input

  # email should be unique
  # dob should not be future date
  validates_presence_of :firstname
  validates :email, :presence => true, :if => Proc.new{ |c| !c.entity.class.to_s.eql?("User")}
  validates :email,  :uniqueness => {:case_sensitive => false}, :if => Proc.new{ |c| !c.email.blank?}
  validate :contactsince_less_than_today
  validate :lastcommunicatedon_less_than_today

  # middleinitial should be Jr., Sr.
  #initials = %w(jr, sr)
#  validates_inclusion_of :middleinitial,:allow_nil=>true,:allow_blank=>true, :in=>I18n.t('patient.mdlinitial_identifiers').keys.map(&:to_s), :on=> :create, :message => " Initials '%s' is not valid. Pl. specify Jr or Sr"
  # allowed settings for pref. contact method
#  validates_inclusion_of :prefcontactmethod,:allow_nil=>true,:allow_blank=>true, :in=>I18n.t('patient.contactmethod_identifiers').keys.map(&:to_s) , :on=> :create, :message => " Contact Method should be 'Post' or 'email' or 'fax'"
  validates_inclusion_of :relatedas,:allow_nil=>true,:allow_blank=>true,  :in=>I18n.t('contact.relationship_identifiers').keys.map(&:to_s), :on=> :create, :message => " Pl. select valid Relationship status"
  validates_inclusion_of :disposition,:allow_nil=>true,:allow_blank=>true,  :in=>I18n.t('contact.disposition_identifiers').keys.map(&:to_s), :on=> :create, :message => " Pl. select valid Dispositionstatus"
#  validates_inclusion_of :gender, :allow_nil=>true,:allow_blank=>true,:in=>I18n.t('patient.gender_identifiers').keys.map(&:to_s), :on=> :create, :message => "Pl. specify Male or Female"

	def self.contactmethods
    I18n.t 'patient.contactmethod_identifiers'
	end

	def self.genders
    I18n.t 'patient.gender_identifiers'
	end

	def self.relations
    I18n.t 'contact.relationship_identifiers'
	end

	def self.disposition
    I18n.t 'contact.disposition_identifiers'
	end

	def contactsince_less_than_today
		if (!contactsince.blank?)
			if (contactsince.to_date > Date.today)
				errors.add(:contactsince,"should not be later than today")		
			end
		end
	end 

	def lastcommunicatedon_less_than_today
		if (!lastcommunicatedon.blank?)
			if (lastcommunicatedon.to_date > Date.today)
				errors.add(:lastcommunicatedon,"should not be later than today")		
			end
		end

	end 

	def datefirststartedimplant_less_than_today
		if (!datefirststartedimplant.blank?)
			if (datefirststartedimplant.to_date > Date.today)
				errors.add(:datefirststartedimplant,"should not be later than today")		
			end
		end

	end 


  #	def prefcontactmethod
  #		attributes = attributes_before_type_cast
  #		if attributes["prefcontactmethod"]
  #			read_attribute(:prefcontactmethod).to_sym
  #		else
  #			nil
  #		end
  #	end

  #	def prefcontactmethod=(value)
  #		write_attribute(:prefcontactmethod, value.to_s)
  #	end

  #	def gender
  #		attributes = attributes_before_type_cast
  #		if attributes["gender"]
  #			read_attribute(:gender).to_sym
  #		else
  #			nil
  #		end
  #	end
	
  #	def gender=(value)
  #		write_attribute(:gender, value.to_s)
  #	end
	
  #	def middleinitial
  #		attributes = attributes_before_type_cast
  #		if attributes["middleinitial"]
  #			read_attribute(:middleinitial).to_sym
  #		else
  #			nil
  #		end
  #	end
	
  #	def middleinitial=(value)
  #		write_attribute(:middleinitial, value.to_s)
  #	end
	
  #	def relatedas
  #		attributes = attributes_before_type_cast
  #		if attributes["relatedas"]
  #			read_attribute(:relatedas).to_sym
  #		else
  #			nil
  #		end
  #	end
	
  #	def relatedas=(value)
  #		write_attribute(:relatedas, value.to_s)
  #	end

	def sanitize_input
		# to remove whitespace, use 
		# self.<fieldname>.strip!
		self.homephone = self.homephone.gsub(/\D/,'') if !self.homephone.blank?
		self.workphone = self.workphone.gsub(/\D/,'') if !self.workphone.blank?
		self.cellphone = self.cellphone.gsub(/\D/,'') if !self.cellphone.blank?
		self.fax = self.fax.gsub(/\D/,'') if !self.fax.blank?
		self.prefcontactmethod = :Email if self.prefcontactmethod.blank?
    #		self.email = self.email.downcase if self.email.present?
	end 
end

# == Schema Information
#
# Table name: contacts
#
#  id                 :integer(4)      not null, primary key
#  entity_id          :integer(4)
#  entity_type        :string(255)
#  firstname          :string(255)
#  lastname           :string(255)
#  middleinitial      :string(255)
#  email              :string(255)
#  address1           :string(255)
#  address2           :string(255)
#  city               :string(255)
#  state              :string(255)
#  zip                :string(255)
#  homephone          :string(255)
#  workphone          :string(255)
#  cellphone          :string(255)
#  fax                :string(255)
#  prefcontactmethod  :string(255)
#  gender             :string(255)
#  contactsince       :date
#  logininfosenton    :date
#  comments           :string(255)
#  isprimary          :boolean(1)
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer(4)
#  photo_updated_at   :date
#  created_at         :datetime
#  updated_at         :datetime
#  relatedas          :string(255)
#  disposition        :string(255)
#  lastcommunicatedon :date
#

