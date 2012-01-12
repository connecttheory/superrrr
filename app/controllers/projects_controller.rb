class ProjectsController < ApplicationController
  
  layout "application"
  
  before_filter :confirm_logged_in, :except => [:list, :sublist, :subabout]
  before_filter :find_user, :except => [:list, :sublist, :subabout]
  
  def index
    redirect_to(:controller => 'access', :action => 'profile')
  end
  
  def list
  	@user = User.find_by_subdomain_name(request.subdomain)
  	if @user.blank?
  	  redirect_to( '/404.html')
  	else
      @projects = @user.projects.order("projects.created_at ASC").visible
    end
  end
  
  
  def show
  	#@user = User.find(session[:user_id])
    @project = Project.find(params[:id])
    @image = Image.new(:project_id => @project.id)
    @project_images = @project.images.order("images.position ASC")
    @project_videos = @project.videos.order("videos.created_at DESC")
    #@project_images = Image.order("images.created_at ASC").where(["project_id = ?", @project.id ])
		
	respond_to do |format|
      format.html { 
        puts "format.html ProjectsC#Show"
				#redirect_to(:controller => 'access', :action => 'profile')
				
      }
      format.json { 
				puts "format.json"
        render :json => @project_images.collect { |p| p.to_jq_upload }.to_json
      }
		end
		
  end
  
    
  def new
    @project = Project.new(:user_id => session[:user_id])
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = 'Project created.'
      redirect_to(:controller => 'access', :action => 'profile')
    else
      render("new")
    end
  end
    
    
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = 'Project updated.'
			respond_to do |format|
				format.html { redirect_to(:action => 'show', :id => params[:id]) }
				format.js
			end
    else
      render("edit")
    end 
  end
  
  
  def delete
    @project = Project.find(params[:id])
  end
  
  def destroy
    Project.find(params[:id]).destroy
    flash[:notice] = "Project deleted."
    redirect_to(:controller => 'access', :action => 'profile')
  end
  
  def preview
    @projects = Project.order("projects.created_at ASC").where(["user_id = ?", session[:user_id] ]).visible
  end
  
  def sublist
  	@user = User.find_by_subdomain_name(request.subdomain)
  	@projects = @user.projects.order("projects.created_at ASC").visible
  	
  	if @projects.blank?
  	  redirect_to( '/404.html')
  	else
      @project = @projects.find(params[:id])
      @project_images = @project.images.order("images.position ASC")
    end
  end
  
  def subabout
  	@user = User.find_by_subdomain_name(request.subdomain)
  	@projects = @user.projects.order("projects.created_at ASC").visible
  end
  
  private
  
  def find_user
    if session[:user_id]
       @user = User.find(session[:user_id])
    end    
  end
  
end
