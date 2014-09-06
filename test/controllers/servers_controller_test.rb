require 'test_helper'

class ServersControllerTest < ActionController::TestCase
  setup do
    @server = servers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:servers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create server" do
    assert_difference('Server.count') do
      post :create, server: { banner: @server.banner, cache_time: @server.cache_time, category_id: @server.category_id, country: @server.country, description: @server.description, disabled: @server.disabled, ip: @server.ip, max_players: @server.max_players, name: @server.name, players: @server.players, port: @server.port, protocol: @server.protocol, server_version: @server.server_version, status: @server.status, user_id: @server.user_id, vip: @server.vip, votes: @server.votes, votifier_ip: @server.votifier_ip, votifier_key: @server.votifier_key, votifier_post: @server.votifier_post, website: @server.website, youtube_id: @server.youtube_id }
    end

    assert_redirected_to server_path(assigns(:server))
  end

  test "should show server" do
    get :show, id: @server
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @server
    assert_response :success
  end

  test "should update server" do
    patch :update, id: @server, server: { banner: @server.banner, cache_time: @server.cache_time, category_id: @server.category_id, country: @server.country, description: @server.description, disabled: @server.disabled, ip: @server.ip, max_players: @server.max_players, name: @server.name, players: @server.players, port: @server.port, protocol: @server.protocol, server_version: @server.server_version, status: @server.status, user_id: @server.user_id, vip: @server.vip, votes: @server.votes, votifier_ip: @server.votifier_ip, votifier_key: @server.votifier_key, votifier_post: @server.votifier_post, website: @server.website, youtube_id: @server.youtube_id }
    assert_redirected_to server_path(assigns(:server))
  end

  test "should destroy server" do
    assert_difference('Server.count', -1) do
      delete :destroy, id: @server
    end

    assert_redirected_to servers_path
  end
end
