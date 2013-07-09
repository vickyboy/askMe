class ApplicationController < ActionController::Base
  protect_from_forgery
    add_breadcrumb "home", :root_path

 def authenticate_any!
    if admin_signed_in?
        true
    else
        authenticate_user!
    end
  end
  
 def index
   
   
 end
end
