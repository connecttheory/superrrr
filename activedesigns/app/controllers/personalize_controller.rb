class PersonalizeController < ApplicationController
  
  before_filter :confirm_logged_in, :except => [:list]
	
  def index
  	@user = User.find(session[:user_id])
  end

end
