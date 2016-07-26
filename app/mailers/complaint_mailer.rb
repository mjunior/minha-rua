class ComplaintMailer < ApplicationMailer
	def new_abuse(url,email,text,reason)
		@reason = reason
		@email = email
		@url = url
		@text = text
		mail(to: ENV['MINHA_RUA_GMAIL_ADMIN'], subject: '[MINHA RUA] - NOVO ABUSO - '+url)
	end

	def reply(url,email,text,name)
		@name = name
		@email = email
		@url = url
		@text = text
		mail(to: ENV['MINHA_RUA_GMAIL_ADMIN'], subject: '[MINHA RUA] - DIREITO DE RESPOSTA - '+url)
	end
end
