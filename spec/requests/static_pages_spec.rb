require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do

    it "should have the content 'Simen' " do

      visit '/static_pages/home'
      page.should have_content('Simen')
  	end
  end

  describe "About page" do

  	it "should have content about" do
  		
	  	visit '/static_pages/about'
	  	page.should have_content('about')
  	end
  end

  describe "Contact page" do
  
  	it "should have content contact" do
  		visit '/static_pages/contact'
  		page.should have_content('contact')	
  	end
  end
end


