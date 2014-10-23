require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET show" do

    render_views

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "returns http success" do
      get :show, :id => @user.id
      expect(response).to have_http_status(:success)
    end 
    
    it "should find the right user" do
      get :show, :id => @user.id
      expect(assigns(:user)).to eql(@user)
    end

    it "should have the right title" do
      get :show, :id => @user.id
      expect(response.body).to include("Ruby on Rails Tutorial Sample App | #{@user.name}")
      #assert_select "title", "Ruby on Rails Tutorial Sample App | #{@user.name}"
    end

    it "should have the user's name" do
      get :show, :id => @user.id
      expect(response.body).to include("#{@user.name}")
      #assert_select "h1", "#{@user.name}"
    end
    
    it "should have a profile name" do
      get :show, :id => @user.id
      expect(response.body).to include("gravatar")
      #assert_select "h1>img", "gravatar"
    end
    
    it "should have the right URL" do
      get :show, :id => @user.id
      expect(response.body).to include("user_path(@user)")
      #assert_select "td>a", "user_path(@user)"
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
