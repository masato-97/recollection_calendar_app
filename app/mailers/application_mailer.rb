class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name(ENV["MAIL_USER_NAME"], "Recordi（レコルディ）")
  layout "mailer"
end
