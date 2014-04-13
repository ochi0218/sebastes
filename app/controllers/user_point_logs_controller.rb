#
# ユーザポイント履歴コントローラ。
#
class UserPointLogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_point_logs = current_user.user_point_logs.by_log_date.page
  end
end
