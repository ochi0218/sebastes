require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { date: @order.date, delivery_date: @order.delivery_date, delivery_fee: @order.delivery_fee, delivery_time_zone_end: @order.delivery_time_zone_end, delivery_time_zone_start: @order.delivery_time_zone_start, destination_address: @order.destination_address, destination_name: @order.destination_name, destination_zip_code: @order.destination_zip_code, fee: @order.fee, order_number: @order.order_number, payment_method: @order.payment_method, use_point: @order.use_point, user_id: @order.user_id }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { date: @order.date, delivery_date: @order.delivery_date, delivery_fee: @order.delivery_fee, delivery_time_zone_end: @order.delivery_time_zone_end, delivery_time_zone_start: @order.delivery_time_zone_start, destination_address: @order.destination_address, destination_name: @order.destination_name, destination_zip_code: @order.destination_zip_code, fee: @order.fee, order_number: @order.order_number, payment_method: @order.payment_method, use_point: @order.use_point, user_id: @order.user_id }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
