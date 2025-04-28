class Batch::RemaindHoliday
  def self.remaind_saturday
    users = User.all
    users.each do |user|
      if user.reminder && user.reminder.mail_receiving_saturday && user.reminder.mail_receiving_saturday == true
        HolidayMailer.holiday_notification(user).deliver_now # メールを送信するためのメソッド
        p "休日通知メール（土曜日）を#{user.name}に送信しました" # ログに表示するメッセージ
      end
    end
  end

  def self.remaind_sunday
    users = User.all
    users.each do |user|
      if user.reminder && user.reminder.mail_receiving_sunday && user.reminder.mail_receiving_sunday == true
        HolidayMailer.holiday_notification(user).deliver_now # メールを送信するためのメソッド
        p "休日通知メール（日曜日）を#{user.name}に送信しました" # ログに表示するメッセージ
      end
    end
  end
end
