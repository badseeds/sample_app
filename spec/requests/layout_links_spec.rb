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
  end
end
