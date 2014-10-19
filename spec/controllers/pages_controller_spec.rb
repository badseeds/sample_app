require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  render_views

  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
    it "should have the right title" do
      get :home
      assert_select "title", "Ruby on Rails Tutorial Sample App | Home"
    end
    it "should have a non-blank body" do
      get :home
      expect(response.body).not_to eql(/<body>\s*<\/body>/)
    end
  end

  describe "GET contact" do
    it "returns http success" do
      get :contact
      expect(response).to have_http_status(:success)
    end
    it "should have the right title" do
      get :contact
      assert_select "title", "Ruby on Rails Tutorial Sample App | Contact"
    end
  end

    describe "GET about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
    it "should have the right title" do
      get :about
      assert_select "title", "Ruby on Rails Tutorial Sample App | About"
    end
  end

end
