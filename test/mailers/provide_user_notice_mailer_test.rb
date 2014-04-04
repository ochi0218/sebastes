require 'test_helper'

class ProvideUserNoticeMailerTest < ActionMailer::TestCase
  test "send_notice_mail" do
    mail = ProvideUserNoticeMailer.send_notice_mail
    assert_equal "Send notice mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
