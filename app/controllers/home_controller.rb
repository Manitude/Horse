class HomeController < ApplicationController

  def index
  	if user_signed_in?
  		redirect_to url_for(:controller => :tenant, :action => :index)
  	else
  		render :layout => false 
  	end
  end

end
