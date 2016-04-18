# This class is used to authenticate the user and perform validations on the user form
# for registering into the application. The password stored for the user is secured 
# using the Use_secure_password.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

class User < ActiveRecord::Base

	# These set the validations for the user data in the form.
 	validates_presence_of :email, :first_name, :last_name, :username
  	validates :email, format: { with: /(.+)@(.+).[a-z]{2,4}/, message: "%{value} is not a valid email" }
  	validates :username, length: { minimum: 3 }
  	validates :first_name, :last_name, format: { with: /\A[A-Za-z]+\z/, message: "%{value} is not a valid name"}
    validates_uniqueness_of :email, :username
	# Users can have interests
	acts_as_taggable_on :interests

	# This is used to make use of secure passwords
	has_secure_password
    has_many :articles

	# This function is used to find a user by username, then check whether it is the same
	# as is stored in the articles table in our database.
	def self.authenticate password, username
		user = User.find_by(username: username)
		if user && user.authenticate(password)
			return user
		else
			return nil
		end
	end

    # This function is used to return the users full name.
	def full_name
		first_name + ' ' + last_name
	end
end
