#
# ユーザポイント履歴コントローラ。
#
class Admin::UserPointLogsController < Admin::ApplicationController
  before_action :set_user
  before_action :authenticate_admin_user!

  # GET /admin/user_point_logs/new
  def new
    @user_point_log = UserPointLog.new
  end

  # POST /admin/user_point_logs
  # POST /admin/user_point_logs.json
  def create
    @user_point_log = @user.user_point_logs.build(user_point_log_params)
    respond_to do |format|
      if @user.add_point_by_system(@user_point_log)
        format.html { redirect_to [:admin, @user], notice: I18n.t('helpers.notice.success.update', { model: UserPointLog.model_name.human }) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id], lock: true)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_point_log_params
      params[:user_point_log].permit(:change_point, :description)
    end
end
