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
  
  has_many :facebook_users, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  
#  accepts_nested_attributes_for :questions
#  accepts_nested_attributes_for :answers

     def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
      fb_user = FacebookUser.where(:provider => auth.provider, :uid => auth.uid).first
        fb_user = FacebookUser.create(provider:auth.provider,
                             uid:auth.uid,
                             nickname:auth.info.nickname,
                             email:auth.info.email,
                             name:auth.extra.raw_info.name,
                             first_name:auth.info.first_name,
                             last_name:auth.info.last_name,
                             image:auth.info.image,
                             urls:auth.info.urls,
                             location:auth.info.location,
                             verified:auth.info.verified,
                             password:Devise.friendly_token[0,20]
                             ) unless fb_user
        fb_user
      end

      
     def self.new_with_session(params, session)
     super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
     end
     end

end
