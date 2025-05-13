class InquiryMailer < ApplicationMailer
  def inquiry_mail(inquiry)
    @inquiry = inquiry
    mail(to: ENV["MAIL_USER_NAME"], subject: "【お問い合わせ】")
  end
end
