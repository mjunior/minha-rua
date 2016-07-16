class HomeController < ApplicationController
  def index

  	@complaintList = Complaint.all

  	if user_signed_in?
  		@logado = true
  	else
  		@logado = false
  	end
  end
end
