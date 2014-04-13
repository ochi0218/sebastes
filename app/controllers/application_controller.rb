class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  #
  # Deviseでのユーザ登録/更新時に許可するパラメータを設定する
  #
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :nick_name << :profile_image
    devise_parameter_sanitizer.for(:account_update) << :nick_name << :profile_image
  end

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    cart.tap {|c| session[:cart_id] = c.id }
  end
end
