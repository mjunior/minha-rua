class ApplicationMailer < ActionMailer::Base
  default from: ENV['MINHA_RUA_EMAIL']
  layout 'mailer'
end
