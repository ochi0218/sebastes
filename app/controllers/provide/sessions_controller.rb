#
# 業務アカウントセッションコントローラ。
#
class Provide::SessionsController < Devise::SessionsController
  layout 'provide/layouts/application'

  def after_sign_in_path_for(resource)
    session[:previous_url] || provide_root_path
  end

  def after_sign_out_path_for(resource)
    admin_root_path
  end
end
