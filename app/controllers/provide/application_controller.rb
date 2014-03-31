#
# サイト管理者用アプリケーションコントローラ
#
class Provide::ApplicationController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout 'provide/layouts/application'
end
