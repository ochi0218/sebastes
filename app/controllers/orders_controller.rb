#
# 注文コントローラ。
#
class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy]
  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders.by_order_date.page
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.from_user_with_cart(current_user, current_cart)
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.build(order_params).with_cart(current_cart)

    respond_to do |format|
      if current_user.purchase(@order, current_cart)
        format.html { redirect_to @order, notice: I18n.t('orders.create.success') }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_user.orders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:destination_zip_code, :destination_address, :destination_name, :payment_method, :use_point, :delivery_date, :delivery_time_zone)
    end
end
