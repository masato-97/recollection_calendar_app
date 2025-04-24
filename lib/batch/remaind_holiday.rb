class Batch::RemaindHoliday
  def self.remaind_holiday
    users = User.all
    users.each do |user|
      HolidayMailer.holiday_notification(user).deliver_now # メールを送信するためのメソッド
      p "休日通知メールを#{user.name}に送信しました" # ログに表示するメッセージ
    end
  end
end
