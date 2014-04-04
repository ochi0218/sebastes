class ProvideUserNotifier < ActionMailer::Base
  default from: "from@example.com"

  def login_info(provide_user)
    @provide_user = provide_user
    mail to: provide_user.email, subject: I18n.t('.subject')
  end
end
