require 'test_helper'

class Admin::UserPointLogsControllerTest < ActionController::TestCase
  setup do
    @admin_user_point_log = admin_user_point_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_user_point_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_user_point_log" do
    assert_difference('Admin::UserPointLog.count') do
      post :create, admin_user_point_log: {  }
    end

    assert_redirected_to admin_user_point_log_path(assigns(:admin_user_point_log))
  end

  test "should show admin_user_point_log" do
    get :show, id: @admin_user_point_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_user_point_log
    assert_response :success
  end

  test "should update admin_user_point_log" do
    patch :update, id: @admin_user_point_log, admin_user_point_log: {  }
    assert_redirected_to admin_user_point_log_path(assigns(:admin_user_point_log))
  end

  test "should destroy admin_user_point_log" do
    assert_difference('Admin::UserPointLog.count', -1) do
      delete :destroy, id: @admin_user_point_log
    end

    assert_redirected_to admin_user_point_logs_path
  end
end
