#
# 管理者セッションコントローラ。
#
class Admin::SessionsController < Devise::SessionsController
  layout 'admin/layouts/application'

  def after_sign_in_path_for(resource)
    session[:previous_url] || admin_root_path
  end

  def after_sign_out_path_for(resource)
    admin_root_path
  end
end
