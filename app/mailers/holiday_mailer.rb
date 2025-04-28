class HolidayMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.holiday_mailer.holiday_notification.subject
  #
  def holiday_notification(user)
    @url = "https://recordi.fly.dev"
    mail(to: user.email, subject: "【Recordi】休日通知メール")
  end
end
