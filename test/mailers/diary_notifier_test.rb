require 'test_helper'

class DiaryNotifierTest < ActionMailer::TestCase
  test "add_comment" do
    mail = DiaryNotifier.add_comment
    assert_equal "Add comment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "add_good" do
    mail = DiaryNotifier.add_good
    assert_equal "Add good", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
