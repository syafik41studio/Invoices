class User < ActiveRecord::Base


  # == Schema Information
  #
  # Table name: users
  #
  #  id                     :integer         not null, primary key
  #  email                  :string(255)     default(""), not null
  #  encrypted_password     :string(128)     default(""), not null
  #  confirmation_token     :string(255)
  #  confirmed_at           :datetime
  #  confirmation_sent_at   :datetime
  #  reset_password_token   :string(255)
  #  reset_password_sent_at :datetime
  #  remember_created_at    :datetime
  #  sign_in_count          :integer         default(0)
  #  current_sign_in_at     :datetime
  #  last_sign_in_at        :datetime
  #  current_sign_in_ip     :string(255)
  #  last_sign_in_ip        :string(255)
  #  suspended              :boolean
  #  created_at             :datetime
  #  updated_at             :datetime
  #  first_name             :string(255)
  #  last_name              :string(255)
  #

  after_initialize :set_full_name
  
  has_and_belongs_to_many :roles
  has_many :conversation_flags
  has_many :conversations, :through => :conversation_flags
  has_many :post_categories
  has_many :posts
  has_one  :profile


  validates :first_name, :last_name, :presence => true
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name,
    :timezone, :slug, :full_name

  extend FriendlyId
  friendly_id :full_name, :use => :slugged

  scope :by_name, lambda{|name|
    where("(users.first_name||' '||users.last_name) ILIKE ?", "%#{name}%")
  }

  scope :not_me, lambda{|user|
    where("id <> ?", user.id)
  }

  def set_full_name
    self.full_name = [self.first_name, self.last_name].join(' ')
  end

  def has_role?(role)
    self.roles.map{|b| b.name}.include?(role)
  end
  
end
