class AboutController < ApplicationController
	def index
		show
		render("show")
	end
	
	def show
		@user = User.find_by_id(session[:user_id])
	end
end
