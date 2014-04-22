#
# 日記通知メーラー。
#
class DiaryNotifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.diary_notifier.add_comment.subject
  #
  def add_comment(diary, comment)
    @diary = diary
    @comment = comment
    mail to: diary.user.email do |format|
      format.html
      format.text
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.diary_notifier.add_good.subject
  #
  def add_good(diary)
    @diary = diary
    mail to: diary.user.email do |format|
      format.html
      format.text
    end
  end
end
