class HomeController < ApplicationController
  def index
  	@nomes = ["Mauricio","Jose","Da","Silva","Junior"];
  	if user_signed_in?
  		@logado = true
  	else
  		@logado = false
  	end
  end
end
