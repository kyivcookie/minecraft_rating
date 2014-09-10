require 'test_helper'

class Admin::ServersControllerTest < ActionController::TestCase
  setup do
    @admin_server = admin_servers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_servers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_server" do
    assert_difference('Admin::Server.count') do
      post :create, admin_server: {  }
    end

    assert_redirected_to admin_server_path(assigns(:admin_server))
  end

  test "should show admin_server" do
    get :show, id: @admin_server
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_server
    assert_response :success
  end

  test "should update admin_server" do
    patch :update, id: @admin_server, admin_server: {  }
    assert_redirected_to admin_server_path(assigns(:admin_server))
  end

  test "should destroy admin_server" do
    assert_difference('Admin::Server.count', -1) do
      delete :destroy, id: @admin_server
    end

    assert_redirected_to admin_servers_path
  end
end
