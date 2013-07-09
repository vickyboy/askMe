class AddPasswordToFacebookUsers < ActiveRecord::Migration
  def change
    add_column :facebook_users, :password, :string
  end
end
