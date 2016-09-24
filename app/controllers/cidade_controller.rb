# Controller cidade
class CidadeController < ApplicationController
  def index
    redirect_to controller: 'home', action: 'index'
  end

  def show
    begin
      @city = Cidade.friendly.find(params[:cidade])
      @complaint_list = Complaint.where(cidade_id: @city)
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
    @lastest = Complaint.last(10).reverse
    @categories = Category.all
    @logado = user_signed_in?
  end

  def search
    nome = params[:nome].strip
    response = []
    if nome.length > 2
      cidades = Cidade.where(['unaccent(nome) ILIKE unaccent(?)', "#{nome}%"])
                      .order(:nome).limit(params[:limit])
      cidades.each do |cidade|
        obj = {}
        obj['label'] = cidade.nome + ' - ' + cidade.estado.sigla
        obj['estado'] = cidade.estado.sigla
        obj['codigo_ibge'] = cidade.codigo_ibge
        obj['path'] = cidade.slug
        response.push(obj)
      end
    end
    respond_to do |format|
      format.html { render nothing: true, status: 200 }
      format.json { render json: response }
    end
  end
end
