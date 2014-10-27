require 'rails_helper'

RSpec.describe "Users", :type => :request do

  #render_views
 
  describe "signup" do
    
    before { visit signup_path }
    let(:submit) { "Create my account" }

  	describe "failure" do

  	  it "should not make a new user" do
  	  	expect{
  	  	  post "/users", :user => {:name => ""}
          post "/users", :user => {:Email => ""}
          post "/users", :user => {:password => ""}
          post "/users", :user => {:confirmation => ""}
          click_button submit
          expect(response).to render_template(:new)
          expect(response.body).to include('div id="error_explanation"')
        }.to_not change(User, :count)
      end
  	end

  	describe "success" do

  	  it "should make a new user" do
  	  	get signup_path
  	  	puts signup_path
  	  	expect{
  	  		puts response.body
  	  		fill_in "user_name", with: "Example User"
  	  	  post "/users", :user => {:name => "Noa di Stavro"}
          post "/users", :user => {:Email => "noa@dude.org"}
          post "/users", :user => {:password => "noanoa"}
          post "/users", :user => {:confirmation => "noanoa"}
          click_button submit
          expect(response.body).to include('div.flash.success')
          #expect(response).to render_template(:show)
        }.to change(User, :count)
      end
  	end

  end
end
