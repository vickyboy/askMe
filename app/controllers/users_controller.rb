class UsersController < ApplicationController
  before_filter :authenticate_admin!
  
  add_breadcrumb "users", :users_path

  
  def index
     @users = User.all
    
    respond_to do |format|
    format.html  # index.html.erb
    format.json  { render :json => @users }
    end
  end
  
  def show

    add_breadcrumb "show", :user_path

    @user = User.find(params[:id]) 
    
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @user }
    end
  end
  
  def new
    add_breadcrumb "new", :new_user_path

    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html  { redirect_to(@user,
                      :notice => 'User successfully submitted.') }
        format.json  { render :json => @user,
                      :status => :created, :location => @user }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @user.errors,
                      :status => :unprocessable_entity }
      end
    end
    
  end
  
  def edit
     add_breadcrumb "edit", :edit_user_path

     @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
 
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html  { redirect_to(@user,
                      :notice => 'User successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @user.errors,
                      :status => :unprocessable_entity }
       end
    end
  
  end
  
  def destroy
     @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url,:notice => 'User successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
end
