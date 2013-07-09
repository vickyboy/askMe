class FacebookUser < ActiveRecord::Base

  attr_accessible :email, :first_name, :image, :last_name, :location, :name, :nickname, :provider, :uid, :urls, :verified, :password
  belongs_to :user
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    @user = User.find_by_email auth.info.email
    unless @user
      @user  =  User.create(:email => auth.info.email, :password => "123456", :password_confirmation => "123456", :username => auth.info.nickname  )
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
        password:Devise.friendly_token[0,20], 
        user_id:@user.id
      ) unless fb_user
    end
    return @user
  end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
