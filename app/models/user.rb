class User < ActiveRecord::Base
  
  mount_uploader :picture, PictureUploader
  
  devise :omniauthable, :omniauth_providers => [:facebook]
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:username]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :picture, :username, :provider, :uid, :name
  # attr_accessible :title, :body
  
  belongs_to :role
  before_create :set_default_role

  private
  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end
  
  has_one :facebook_user, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  
#  accepts_nested_attributes_for :questions
#  accepts_nested_attributes_for :answers

     
  
      
   
end
