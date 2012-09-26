class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :require_login
  
  private
  
  def require_login
    unless logged_in?
      flash[:error] = "Voce deve estar logado para acessar esta secao"
      redirect_to new_login_url # Previne que a ação corrente seja executada
      end 
  end
  
  # O método logged_in? simplesmente retorna true se o usuário estiver logado
  # e false em caso contrário. Ele faz isto "booleanizando" o método current_user
  # que nós criamos anteriormente utilizando um operador ! duplo. Saiba que isto
  # não é comum em Ruby e é desencorajado a não ser que você realmente queira converter
  # algo em true ou false.
  def logged_in?
    !!current_user 
  end
    
  private
  # Encontra o User com o ID armazenado na sessão com a chave :current_user_id
  # Esta é uma forma comum de lidar com login de usuários em uma aplicação Rails;
  # Durante o login o valor é armazenado, e no logout ele é removido.
  def current_user
    @_current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
  end
end