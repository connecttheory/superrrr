class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  
  protected
	  
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'access', :action => 'login')
      return false # halts the before_filter
    else
      return true
    end
  end
	
	def is_logged_in?
	  unless session[:user_id]
        return false # halts the before_filter
      else
        return true
      end
	end
	
  def current_user
  	@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  def session_user
    @session_user = User.find(session[:user_id]) if session[:user_id]
  end

end
