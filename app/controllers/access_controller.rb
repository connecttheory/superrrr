class AccessController < ApplicationController
  
  layout "application"
  
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
  def index
    profile
    render('profile')
  end
  
  def login
		if self.is_logged_in?
			flash[:notice] = "You are currently logged."
			redirect_to({:controller => 'access', :action => 'profile'})
		end	
    #login form
  end
  

  def profile
    # show user profile
    @user = User.find(session[:user_id])
    @projects = @user.projects.order("projects.created_at ASC")
    @images = @user.images
    #@project_thumb = Project.lastest(@projects)
    @cpanel_test = User.create_cpanel_acct
  end

  def attempt_login
    authorized_user = User.authenticate(params[:username], params[:password])
    if authorized_user
      if params[:remember_me]
        cookies.permanent[:auth_token] = authorized_user.auth_token
      else
      	cookies[:auth_token] = authorized_user.auth_token
      end

      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      #flash[:notice] = "You are now logged in."
      redirect_to(:action => 'profile')
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
    
  end
  
  def logout
  	cookies.delete(:auth_token)
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You have been logged out."
    redirect_to(:action => "login")
  end

end
