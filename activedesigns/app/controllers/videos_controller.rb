class VideosController < ApplicationController
	
  before_filter :find_project
  before_filter :confirm_logged_in
	
  def index
  end
  
  def edit
  	@video = Video.find(params[:id])
  end
  def update
    @video = Video.find(params[:id])
    if @video.update_attributes(params[:video])
      flash[:notice] = 'Video updated.'
			respond_to do |format|
				format.html { redirect_to(:controller => 'projects', :action => 'show', :id => @video.project_id) }
				format.js
			end
    else
      render("edit")
    end 
  end
  
  def new
    @video = Video.new(:project_id => @project.id)
  end
  
  def create
    @video = Video.new(params[:video])
    @video.project_id = params[:id]
    if @video.save
			
	  redirect_to(:controller => 'projects', :action => 'show', :id => @video.project_id)
    else
	  respond_to do |format|
        format.html { 
          flash[:notice] = 'Image creation failed.'
          #redirect_to(:controller => 'projects', :action => 'show', :id => @project.id)
        }
        format.json { 
          render :json => [{:error => "custom_failure"}], :status => 304
        }
      end
    end
  end
  
  private
  
  def find_project
    if params[:project_id]
       @project = Project.find_by_id(params[:project_id])
    end    
  end

end
