# This Controller is used to manage the application by ensuring that only a 
# valid user is able to access the resources of this site (The Digest).
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
# 

class ApplicationController < ActionController::Base
  
  # This is used to prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  # This is to include session helper module.
  include SessionsHelper

  # This function is used to check if the user is not authenticated then they
  # would be redirected to the login page.
  def authenticate_user
  	if !current_user
  		redirect_to login_path 
  	end
  end
end
