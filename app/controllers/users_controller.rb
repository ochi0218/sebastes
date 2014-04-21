#
# ユーザコントローラ。
#
class UsersController < ApplicationController
  before_action :authenticate_user!

  def destination_edit
    @user = current_user
  end

  def destination_update
    respond_to do |format|
      if current_user.update_with_lock(user_destination_params)
        format.html { redirect_to root_path, notice: I18n.t('helpers.notice.success.update', { model: User.model_name.human }) }
      else
        format.html { render action: 'destination_edit' }
      end
    end
  end

  private

    def user_destination_params
      params[:user].permit(:destination_zip_code, :destination_address, :destination_name)
    end
end
