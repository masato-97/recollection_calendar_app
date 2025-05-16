class HolidayMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.holiday_mailer.holiday_notification.subject
  #
  def holiday_notification(user)
    @url = "https://recordi.jp/memories/new"
    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: "【休日通知】思い出を残しましょう！"
    )
  end
end
