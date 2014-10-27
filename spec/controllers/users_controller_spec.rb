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
    end

    it "should have the user's name" do
      get :show, :id => @user.id
      expect(response.body).to include("#{@user.name}")
    end
    
    it "should have a profile name" do
      get :show, :id => @user.id
      expect(response.body).to include("gravatar")
    end
    
    it "should have the right URL" do
      visit user_path(@user)
      expect(page).to have_selector("td>a[href='#{user_path(@user)}']", :text=> user_path(@user))
    end

  end

  describe "GET new" do

    render_views

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end 

    it "should have the right title" do
      get :new
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Sign up")
    end

  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :email =>"", :password => "", :password_confirmation => ""}
      end

      it "should have the right title" do
        post :create, :user => @attr
        expect(response.body).to include("Sign up")
      end

      it "should render the new page" do
        post :create, :user => @attr
        expect(response.body).to render_template('new')
      end

      it "should not create a user" do       
        expect{
          post :create, :user => @attr
        }.to_not change(User, :count)
      end

    end

  end


  describe "success" do

    before(:each) do
      @attr = { :name => "Noa di Stavro", :email =>"noa@dude.com", :password => "zoraki", :password_confirmation => "zoraki"}
    end

    it "should create a user" do       
      expect{
      post :create, :user => @attr
      }.to change(User, :count).by(1)
    end

    it "should redirect to the user page" do
      post :create, :user => @attr
      expect(response).to redirect_to(user_path(assigns(:user)))
    end

    it "should have a welcome message" do
      post :create, :user => @attr
      flash[:success].should =~ /welcome to the sample app/i 
    end

  end

end
