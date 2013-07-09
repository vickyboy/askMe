class AddColumnUserIdToFacebookUsers < ActiveRecord::Migration
  def change
    add_column :facebook_users, :user_id, :integer
  end
end
