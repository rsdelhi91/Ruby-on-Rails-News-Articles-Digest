# This controller is used to manage the sessions of the users for our application.
# This signifies the various types of sessions and how they are controlled.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

class SessionsController < ApplicationController

  # This is to signiify the before actions to perform login and logout.
  before_action :check_params, only: [:login]
  before_action :authenticate_user, only: [:logout]

  
  # This method is used to find a user with the username and password pair, 
  # log in that user if they exist in the database. 
  def login
  	# This finds a user which exists in the database. We will only login a user if
    # they are registered with our app.
  	user = User.authenticate(@credentials[:password], @credentials[:username])
  	if user
	  	# If the user is authentiicated, we save them in the session.
	  	log_in user
	  	redirect_to articles_path
	  else
      # If user is not authenticated we redirect them to the articles_path.
		  redirect_to :back
	  end
  end

  # This method logs out the user in the session and redirects them to the unauth page.
  def logout
  	log_out
  	redirect_to login_path 
  end

  # These are private controller methods for the Sessions Controller.
  private
  def check_params
  	params.require(:credentials).permit(:password, :username)
  	@credentials = params[:credentials]
  end

end
