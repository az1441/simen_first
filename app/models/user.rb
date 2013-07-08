class User < ActiveRecord::Base

#makes columns in DB accesible  
  attr_accessible :email, :name, :password, :password_confirmation

# Does a lot of crazy stuff: To add password and password_confirmation 
#attributes, require the presence of the password, require that they match, 
# and add an authenticate method to compare an encrypted password 
# to the password_digest to authenticate users. All these features
# come for free with one method: has_secure_password.

  has_secure_password
  
 # callback that converts email addresses to downcase because not all
 # DBs are case sensitive. Also makes finding user by email more efficient.

  before_save { |user| user.email = email.downcase }
 
 # adds validation that there is actually
 # name/email/password/password confirmation data present when creating 
 # new user in DB.  Email format is checked by email regex. More regex 
 #in Hartl Chapt. 6. Uniqueness checks that email is not duplicated. 
 # Can see that it is also not case sensitive.
 
  validates(:name,  presence: true, length: {maximum: 50})
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates(:email, presence: true, format: {with: VALID_EMAIL_REGEX},
  			uniqueness: {case_sensitive: false})
  validates(:password, presence: true, length: {minimum: 6} )
  validates :password_confirmation, presence: true
end
