# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#

require 'rails_helper'

RSpec.describe User, :type => :model do

  before (:each) do
  	 @attr = { :name => "Example User", :email => "user@example.com" , password: "foobar", password_confirmation: "foobar"}
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
    #expect(@attr).to be_valid
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name =>""))
    expect(no_name_user).to_not be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email =>""))
    expect(no_email_user).to_not be_valid
  end

  it "should reject names that are too long" do
  	long_name = 'a' * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    expect(long_name_user).to_not be_valid
  end

  it "should accept valid email addresses" do
  	addresses = %w[user@foo.com THE_USER@foo.bar.org foo.bar@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      expect(valid_email_user).to be_valid
    end
  end

  it "should reject invalid email addresses" do
  	addresses = %w[user@foo,com user_at_foo.bar.org foo.bar@foo.jp.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      expect(invalid_email_user).to_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
  	User.create!(@attr)
    user_with_duplicated_email = User.new(@attr)
    expect(user_with_duplicated_email).to_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = "USER@EXAMPLE.COM"
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicated_email = User.new(@attr)
    expect(user_with_duplicated_email).to_not be_valid
  end

  describe "passwords" do

    before (:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      expect(@user.password).to_not eql("")
    end

    it "should have a password contribution attribute" do
      expect(@user.password_confirmation).to_not eql("")
    end
  end
  
  describe "password validations" do

    it "should require a password" do
      expect(User.new(@attr.merge(:password => "", :password_confirmation => ""))).to_not be_valid
    end

    it "should require a matching password confirmation" do
      expect(User.new(@attr.merge(:password_confirmation => "invalid"))).to_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      expect(User.new(hash)).to_not be_valid
    end

  end

  describe "password encryption" do

    before (:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      expect(@user).to respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      expect(@user.encrypted_password).to_not eql("")
    end

    it "should have a salt" do
      expect(@user).to respond_to(:salt)
    end

  end

  describe "has_password? method" do

    before (:each) do
      @user = User.create!(@attr)
    end
 
    it "should exist" do
      expect(@user).to respond_to(:has_password?)
    end   

    it "should return true if the passwords match" do
      expect(@user.has_password?(@attr[:password])).to eql(true)
    end 

    it "should return false if the passwords don't match" do
      expect(@user.has_password?("invalid")).to eql(false)
    end 

  end

  describe "authenticate method" do

    before (:each) do
      @user = User.create!(@attr)
    end

    it "should exist" do
      expect(@user).to respond_to(:authenticate)
    end 
  
    it "should return nil on email/password mismatch" do
      wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
      expect(wrong_password_user).to be_nil
    end
  
    it "should return nil for an email address with no user" do
      nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
      expect(nonexistent_user).to be_nil
    end
    
    it "should return the user on email/password match" do
      matching_user = User.authenticate(@attr[:email], @attr[:password])
      expect(matching_user).to eql(@user)
    end
  end  

end
