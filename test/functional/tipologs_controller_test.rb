require 'test_helper'

class TipologsControllerTest < ActionController::TestCase
  setup do
    @tipolog = tipologs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipologs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipolog" do
    assert_difference('Tipolog.count') do
      post :create, tipolog: { nome: @tipolog.nome }
    end

    assert_redirected_to tipolog_path(assigns(:tipolog))
  end

  test "should show tipolog" do
    get :show, id: @tipolog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipolog
    assert_response :success
  end

  test "should update tipolog" do
    put :update, id: @tipolog, tipolog: { nome: @tipolog.nome }
    assert_redirected_to tipolog_path(assigns(:tipolog))
  end

  test "should destroy tipolog" do
    assert_difference('Tipolog.count', -1) do
      delete :destroy, id: @tipolog
    end

    assert_redirected_to tipologs_path
  end
end
