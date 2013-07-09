class FacebookUser < ActiveRecord::Base

  attr_accessible :email, :first_name, :image, :last_name, :location, :name, :nickname, :provider, :uid, :urls, :verified, :password
  belongs_to :user
  

end
