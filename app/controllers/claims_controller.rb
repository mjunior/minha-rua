class ClaimsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@user = current_user
		@claims = Claim.where(user:current_user)

	end

	def new
		@user = current_user
		@categories = Category.all
	end

	# Função chamada pelo form em new

	def create
	  c = Claim.new(claim_params);
	  c.user = current_user;
	  c.save


	  render plain: c.inspect
	end

	def claim_params
		 params.require(:claim).permit(:lat, :lng, :body, :category)
	end


	# 
end
