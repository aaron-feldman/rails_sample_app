class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def new
    # TODO: "should be here??? @user in ApplicationsController???"
    @user = User.new 
  end
  
  private
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:warning] = "Please log in."
        redirect_to login_url
      end
    end
end