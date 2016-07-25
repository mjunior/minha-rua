class ComplaintMailer < ApplicationMailer
	def new_abuse(url,text)
		@url = url
		@text = text
		mail(to: ENV['MINHA_RUA_GMAIL_ADMIN'], subject: '[MINHA RUA] - NOVO ABUSO')
	end
end
