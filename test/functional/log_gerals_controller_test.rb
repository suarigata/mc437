require 'test_helper'

class LogGeralsControllerTest < ActionController::TestCase
  setup do
    @log_geral = log_gerals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:log_gerals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create log_geral" do
    assert_difference('LogGeral.count') do
      post :create, log_geral: { data: @log_geral.data, desc: @log_geral.desc, sistema: @log_geral.sistema, tipolog: @log_geral.tipolog, user: @log_geral.user }
    end

    assert_redirected_to log_geral_path(assigns(:log_geral))
  end

  test "should show log_geral" do
    get :show, id: @log_geral
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @log_geral
    assert_response :success
  end

  test "should update log_geral" do
    put :update, id: @log_geral, log_geral: { data: @log_geral.data, desc: @log_geral.desc, sistema: @log_geral.sistema, tipolog: @log_geral.tipolog, user: @log_geral.user }
    assert_redirected_to log_geral_path(assigns(:log_geral))
  end

  test "should destroy log_geral" do
    assert_difference('LogGeral.count', -1) do
      delete :destroy, id: @log_geral
    end

    assert_redirected_to log_gerals_path
  end
end
