# Controller da pagina inicial
class HomeController < ApplicationController
  def index
    @complaint_list = Complaint.all
    @lastest = Complaint.last(10).reverse
    @categories = Category.all
    @logado = user_signed_in?
  end
end
