require "test_helper"

class HolidayMailerTest < ActionMailer::TestCase
  test "holiday_notification" do
    mail = HolidayMailer.holiday_notification
    assert_equal "Holiday notification", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
