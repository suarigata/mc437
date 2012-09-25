require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { cpf: @user.cpf, dica_senha: @user.dica_senha, email_1: @user.email_1, email_2: @user.email_2, nome: @user.nome, resposta_dica_senha: @user.resposta_dica_senha, rg: @user.rg, senha: @user.senha, sistema: @user.sistema, status: @user.status, usertype: @user.usertype }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { cpf: @user.cpf, dica_senha: @user.dica_senha, email_1: @user.email_1, email_2: @user.email_2, nome: @user.nome, resposta_dica_senha: @user.resposta_dica_senha, rg: @user.rg, senha: @user.senha, sistema: @user.sistema, status: @user.status, usertype: @user.usertype }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
