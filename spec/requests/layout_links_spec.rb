require 'rails_helper'

RSpec.describe "LayoutLinks", :type => :request do
  describe "GET /layout_links" do
    it "should have a Home page at '/'" do
      get '/' 
      assert_select "title", "Ruby on Rails Tutorial Sample App | Home"
    end
  
    it "should have a Contact page at '/contact'" do
      get '/contact' 
      assert_select "title", "Ruby on Rails Tutorial Sample App | Contact"
    end
  
  it "should have an About page at '/about'" do
      get '/about' 
      assert_select "title", "Ruby on Rails Tutorial Sample App | About"
    end

    it "should have a Help page at '/help'" do
      get '/help' 
      assert_select "title", "Ruby on Rails Tutorial Sample App | Help"
    end 

    it "should have a signup page at '/signup'" do
      get '/signup' 
      assert_select "title", "Ruby on Rails Tutorial Sample App | Sign up"
    end 

    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      expect(page).to have_title("About")
      click_link "Help"
      expect(page).to have_title('Help')
      click_link "Contact"
      expect(page).to have_title('Contact')
      click_link "Home"
      expect(page).to have_title('Home')
      click_link "Sign up"
      expect(page).to have_title('Sign up')
      expect(page).to have_selector('a[href="/"]>img')
    end
  end
end
