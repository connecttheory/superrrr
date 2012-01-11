class UsersController < ApplicationController

  before_filter :confirm_logged_in, :except => [:signup, :signup_process, :crop]
  
  def index
    list
    render('list')
  end
  
  def list
    @users = User.sorted
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:notice] = 'Secessfully Signed up!'
      if params[:user][:photo].blank?
        redirect_to(:action => 'list')
      else
        render :action => "crop"
      end
    else
      render("new")
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User updated.'
      if params[:user][:avatar].present?
      	# the logo params is there then send it to crop avatar
        render :action => "crop"
      elsif params[:user][:logo].present?
      	# the logo params is there then send it to crop logo
      	render :action => "crop_logo"
      else
      	#redirect depending on edit situation
      	if params[:logo].to_i == 1
		  respond_to do |format|
			format.html { redirect_to(:controller => 'personalize' ) }
			format.js
		  end
	    else
		  respond_to do |format|
			format.html { redirect_to(:controller => 'about' ) }
			format.js
		  end
	    end
      end #if params[:user][:avatar].present?

    else #if failed to update user record
      render("edit")
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    cur_user = self.current_user
    session_user = self.session_user
    request_user_del = User.find_by_id(params[:id])
    
  	if User.del_validated(cur_user, session_user, request_user_del)
  	  User.find_by_id(params[:id]).destroy
      cookies.delete(:auth_token)
      session[:user_id] = nil
      session[:username] = nil
      flash[:notice] = "User Account: #{cur_user.name} was destroyed."
      redirect_to(:controller => 'access', :action => 'login' )
    else
      redirect_to( root_url + '404.html' )
  	end	


  end
  
  #public User
  
  def signup
		if self.is_logged_in?
			flash[:notice] = "You are currently logged."
			redirect_to({:controller => 'access', :action => 'profile'})
		end	
    @user = User.new
  end
	  
  def signup_process
    @user = User.new(params[:user])
    @user.subdomain_name = params[:user][:username]
    @user.header_title = params[:user][:username] + "'s Porfolio"
    @user.footer_title = Time.now.year
    if @user.save
      #UserMailer.registration_confirmation(@user).deliver
      # auto login
      authorized_user = User.authenticate(@user.username, @user.password)
      if authorized_user
      	cookies.permanent[:auth_token] = user.auth_token
      	session[:user_id] = @user.id
      	session[:username] = @user.username
        flash[:notice] = 'Welcome to our new site!!.'
        if !params[:user][:photo].blank?
          redirect_to(:controller => 'access', :action => 'profile')
        else
          render :action => "crop"
        end
      end
      redirect_to(:controller => 'access', :action => 'profile')
    else
      render("signup")
    end
  end
	
end
