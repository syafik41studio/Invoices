class User < ActiveRecord::Base

  has_and_belongs_to_many :roles
  has_many :conversation_flags
  has_many :conversations, :through => :conversation_flags

  validates :first_name, :last_name, :presence => true
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  has_many :posts

  scope :by_name, lambda{|name|
    where("(users.first_name||' '||users.last_name) ILIKE ?", "%#{name}%")
  }

  scope :not_me, lambda{|user|
    where("id <> ?", user.id)
  }

  def full_name
    [first_name, last_name].join(' ')
  end
  
end
