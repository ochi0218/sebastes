require 'test_helper'

class ProvideUsersControllerTest < ActionController::TestCase
  setup do
    @provide_user = provide_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:provide_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provide_user" do
    assert_difference('ProvideUser.count') do
      post :create, provide_user: {  }
    end

    assert_redirected_to provide_user_path(assigns(:provide_user))
  end

  test "should show provide_user" do
    get :show, id: @provide_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @provide_user
    assert_response :success
  end

  test "should update provide_user" do
    patch :update, id: @provide_user, provide_user: {  }
    assert_redirected_to provide_user_path(assigns(:provide_user))
  end

  test "should destroy provide_user" do
    assert_difference('ProvideUser.count', -1) do
      delete :destroy, id: @provide_user
    end

    assert_redirected_to provide_users_path
  end
end
