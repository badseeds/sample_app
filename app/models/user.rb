# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	
  validates :name, :presence    => true, 
                   :length      => {:maximum => 50 }

  Valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence   => true, 
                    :format     => { :with => Valid_email_regex },
                    :uniqueness => {:case_sensitive => false}
end
