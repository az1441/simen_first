require 'spec_helper'

describe "StaticPages" do
  subject {page}

  describe "Home page" do
    
    before{visit root_path}
     
      it {should have_selector('title', text: full_title('Home')) }
      it {should have_selector('h1', text: 'Welcome')}
  end

  describe "About page" do

  	before{visit about_path}
     
      it {should have_selector('title', text: full_title('About')) }
      it {should have_selector('h1', text: 'About') }
  end

  describe "Content page" do
  
  	before{visit content_path}
     
      it {should have_selector('title', text: full_title('Content')) }
      it {should have_selector('h1', text: 'Content')}
  end

  it "should have the right links on the layout" do
    visit root_path

    click_link "Content"
    page.should have_selector('title', text: full_title('Content') )
    click_link "Home"
    page.should have_selector('title', text: full_title('Home') )

    click_link "Home"
    click_link "Sign up now"
    page.should have_selector('title', text: full_title('Sign up') )
    
  end
end


