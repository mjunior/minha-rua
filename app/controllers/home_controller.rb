# Controller da pagina inicial
class HomeController < ApplicationController
  def index
    @complaint_list = Complaint.all
    @lastest = Complaint.last(10).reverse
    @categories = Category.all
    @logado = user_signed_in?
  end

  def contato
    response = { status: 'success' }
    begin
      IndexMailer.contato(params[:nome], params[:email], params[:entidade],
                          params[:telefone]).deliver_later
    rescue => ex
      logger.debug ex
      response.status = 'error'
    end
    respond_to do |format|
      format.html { render nothing: true, status: 200 }
      format.json { render json: response, status: 200 }
    end
  end
end
