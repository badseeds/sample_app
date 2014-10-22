require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  render_views	

  describe "GET show" do

    before(:each) do
      @user = FactoryGirl.build(:user)
    end

    it "returns http success" do
      get :show, :id => @user
      expect(response).to have_http_status(:success)
    end 
    
    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).to eql(@user)
    end

  end

  describe "GET new" do

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end 

    it "should have the right title" do
      get :new
      assert_select "title", "Ruby on Rails Tutorial Sample App | Sign up"
    end

  end

end
