# This module is used to maintain the sessions of the user of our application.
# It will help maintain the session even after the server is switched off then
# back on.

module SessionsHelper

	# This function is used to Log in a user after authenticating then store in session.
	def log_in user
		session[:user_id] = user.id
	end

	# This function is used to return the currently logged in user for this session.
	def current_user
		if !@current_user
			@current_user =  User.find_by(id: session[:user_id])
		end
		@current_user
	end

	# This function is used to Log out a user.
	def log_out
		session[:user_id] = nil
	end

end
