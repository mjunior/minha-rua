class IndexMailer < ApplicationMailer
  def contato(nome, email, entidade, telefone)
    @nome = nome
    @email = email
    @entidade = entidade
    @telefone = telefone
    mail(to: ENV['MINHA_RUA_GMAIL_ADMIN'], subject: nome + ' CONTATO - GOVERNO')
  end
end
