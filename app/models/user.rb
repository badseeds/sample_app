# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  email                :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  encrypted_passwomord :string(255)
#

class User < ActiveRecord::Base

  attr_accessor        :password, :password_confirmation

  validates :name,     :presence    => true, 
                       :length      => {:maximum => 50 }

  Valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email,    :presence   => true, 
                       :format     => { :with => Valid_email_regex },
                       :uniqueness => {:case_sensitive => false}

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 }
end
