class ImagesController < ApplicationController
  

  before_filter :find_project
  before_filter :confirm_logged_in
  
  def index
    list
    #render("list")
  end
  
  def list
    @image = Image.new(:project_id => @project.id)
    @images = Image.order("images.created_at ASC").where(["project_id = ?", @project.id ])
	  render :json => @images.collect { |p| p.to_jq_upload }.to_json
		#respond_to do |format|
      #format.html { 
       # puts "format.html ImagesC list"
				#render :json => @images.collect { |p| p.to_jq_upload }.to_json
      #}
      #format.json { 
        #
      #}
		#end
  end
  
  def show
    @image = Image.find(params[:id])
  end
  
  def new
    @image = Image.new(:project_id => @project.id)
  end
  
  def create
    @image = Image.new(params[:image])
    if @image.save
	  render :json => [@image.to_jq_upload].to_json
			
	  #redirect_to(:controller => 'projects', :action => 'show', :id => @project.id)
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
  
  def edit
    @image = Image.find(params[:id])
  end
  
  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      flash[:notice] = 'Image updated.'
			respond_to do |format|
				format.html { redirect_to(:controller => 'projects', :action => 'show', :id => @image.project_id) }
				format.js
			end
    else
      render("edit")
    end 
  end
  
  def sort
    params[:image].each_with_index do |id, index|
      Image.update_all({:position => index+1}, {:id => id})
    end
    render :nothing => true
  end
  
  def delete
    @image = Image.find(params[:id]).destroy
	  respond_to do |format|
        format.html { 
          flash[:notice] = "Image deleted."
          redirect_to(:controller => 'projects', :action => 'show', :id => params[:project_id])
        }
        format.json { 
          render :json => true
        }
      end
  end
  
  private
  
  def find_project
    if params[:project_id]
       @project = Project.find_by_id(params[:project_id])
    end    
  end
  
  
end
