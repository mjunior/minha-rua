class HomeController < ApplicationController
  def index

  	@complaintList = Complaint.all
  	@lastest = Complaint.last(10).reverse
  	@topList = Complaint.order(likes: :desc)
    @categories = Category.all
  	if user_signed_in?
  		@logado = true
  	else
  		@logado = false
  	end

  end
end
