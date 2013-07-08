class AddPasswordDigestToUsers < ActiveRecord::Migration
  
# adds column password_digest to table users.
  def change
    add_column :users, :password_digest, :string
  end
end
