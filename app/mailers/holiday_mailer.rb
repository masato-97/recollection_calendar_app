class HolidayMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.holiday_mailer.holiday_notification.subject
  #
  def holiday_notification(user)
    @url = "http://localhost:3000/memories"
    mail(to: user.email, subject: "【Recordi】ホリデーリマインダー")
  end
end
