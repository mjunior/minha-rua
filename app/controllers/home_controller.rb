# Controller da pagina inicial
class HomeController < ApplicationController
  def index
    @complaint_list = Complaint.all
    @lastest = Complaint.last(10).reverse
    @categories = Category.all
    @logado = user_signed_in?
  end

  def contato
  	logger.debug "enviando email de contato"
  	logger.debug "enviando email de contato"
  	logger.debug "enviando email de contato"
  	begin
  		IndexMailer.contato(params[:nome],
                                params[:email],
                                params[:entidade],
                                params[:telefone]).deliver_later
  	rescue => ex
        logger.debug 'ERRO ENVIAR EMAIL'
    	logger.debug ex.message
 	end

  	response = "Enviado com sucesso".to_json
  	respond_to do |format|
      format.html { render nothing: true, status: 200 }
      format.json { render json: response }
    end
  end
end
