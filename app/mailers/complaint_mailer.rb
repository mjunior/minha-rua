class ComplaintMailer < ApplicationMailer
  def new_abuse(url, email, text, reason)
    @reason = reason
    @email = email
    @url = url
    @text = text
    mail(to: ENV['MINHA_RUA_GMAIL_ADMIN'],
         subject: '[MINHA RUA] - NOVO ABUSO - ' + url)
  end

  def reply(url, email, text, name)
    @name = name
    @email = email
    @url = url
    @text = text
    mail(to: ENV['MINHA_RUA_GMAIL_ADMIN'],
         subject: '[MINHA RUA] - DIREITO DE RESPOSTA - ' + url)
  end

  def new_complaint(url, email)
    @email = email
    @url = url
    mail(to: ENV['MINHA_RUA_GMAIL_ADMIN'],
         subject: '[MINHA RUA] - NOVA RECLAMACAO - ' + url)
  end

  def like_complaint(name, url, to)
    @name = name
    @url = 'http://minharuatemproblema.com.br/complaints/' + url
    mail(to: to, subject: name + ' apoiou sua reclamação')
  end
end
