# This controller is used to manage the user, like creating a user, updating their
# details, and destroying a users profile. We set the authentication required to
# perform edit, update and show on a users profile here.
#
# Author::  Rahul Sharma (Student No: 706453, student ID: sharma1)
#

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :destroy, :update]
  before_action :check_valid, only: [:edit, :destroy, :update]

  # This function is used to create a new user.
  def new
    @user = User.new
  end

  # This function is here to set edit.
  def edit
  end

  # This function creates a user and saves them.
  def create
    @user = User.new(user_params)  
    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to articles_path, notice: 'user was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # This function is used to update the users details.
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to articles_path, notice: 'user was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # This function is used to destroy a users profile.
  def destroy
    #log_out @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to login_path, notice: 'user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # This function uses callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # This fuunction is used to check whether the user trying to access a resource is a current user
    # or not. If no, they will be re-directed to the articles_path.
    def check_valid
      unless @user==current_user
        redirect_to articles_path
      end
    end

    # This function is used to set the white list for our users.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :bio, :username, :password, :interest_list, :password_confirmation)
    end
end
