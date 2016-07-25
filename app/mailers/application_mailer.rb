class ApplicationMailer < ActionMailer::Base
  default from: ENV['MINHA_RUA_GMAIL_EMAIL']
  layout 'mailer'
end
