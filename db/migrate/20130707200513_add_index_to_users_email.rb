class AddIndexToUsersEmail < ActiveRecord::Migration
  
  # Method adds index to the email COLUMN of users TABLE in DB.
  # Uniqueness:true ensures uniqueness preventing double email entries.
  
  def change
  	add_index :users, :email, unique: true
  end
end
