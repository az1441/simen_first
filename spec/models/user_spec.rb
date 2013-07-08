require 'spec_helper'

describe User do
	before {@user = User.new(name: "Test User", email: "testuser@example.com",
					password: "foobar", password_confirmation: "foobar")}
			
	subject { @user }

#Checking if the created @user has these attributes: 

	it {should respond_to(:name) }
	it {should respond_to(:email) }	
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }

	it {should be_valid}

#Checking if name/email/password is present as well as when
#name is too long or password too short.
	
	describe "when name is not present" do
		
		before {@user.name= " "}	
		it {should_not be_valid}
	end

	describe "when email is not present" do
		
		before {@user.email= " "}	
		it {should_not be_valid}
	end

	describe "when password is not present" do
	  before { @user.password = @user.password_confirmation = " " }
	  it { should_not be_valid }
	end

	describe "when name is too long" do
    	before { @user.name = "a" * 51 }
   	 	it { should_not be_valid }
  	end

	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a" * 5 }
		it { should be_invalid }
	end

#cheking email formats. Check that most common email formats are actually
#valid, and most common error formats are invalid.

  	describe "when email format is invalid" do
	    it "should be invalid" do
	      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
	                     foo@bar_baz.com foo@bar+baz.com]
	      addresses.each do |invalid_address| 
	        @user.email = invalid_address
	        @user.should_not be_valid
	      end      
	    end
    end

	describe "when email format is valid" do
		it "should be valid" do
		  addresses = %w[user@foo.COM A_US-ER@f.b.org 
		  				frst.lst@foo.jp a+b@baz.cn]
		  addresses.each do |valid_address|
		    @user.email = valid_address
		    @user.should be_valid
		  end      
		end
	end

 # checking if email is already taken. Duplicates user and saves it. It should
 # then not be valid. Checked in User.rb by Uniqueness. Also checks UPCASE.

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

#Ensures that passwords match. "foobar" is set as password for @user
#at top of this file so this test will give invalid user as long
#as the password below is anything else but "foobar"

	describe "when password doesn't match confirmation" do
	  before { @user.password_confirmation = "anythingbutfoobar" }
	  it { should_not be_valid }
	end

#Some console only stuff where password_confirmation can be nil

	describe "when password confirmation is nil" do
	  before { @user.password_confirmation = nil }
	  it { should_not be_valid }
	end

#Authentication tests. Authentication finds user by email and is only valid 
#if passwords match. Thelet method is read like this: "let :found_user
# be User.find_by_email...". 

	describe "return value of authenticate method" do
	  before { @user.save }
	  let(:found_user) { User.find_by_email(@user.email) }

	  describe "with valid password" do
	    it { should == found_user.authenticate(@user.password) }
	  end

	  describe "with invalid password" do
	    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

	    it { should_not == user_for_invalid_password }
	    specify { user_for_invalid_password.should be_false }
	  end
	end

end
