class UserController < ApplicationController

	def show
		@user = User.find_by_id(params[:id])
		unless @user
			redirect_to root_url
		end
	end

	def create
		@user = User.create(params[:user])
		if @user
			render :json => @user
		else
			render :nothing => true, :status => 404
		end
	end

end
