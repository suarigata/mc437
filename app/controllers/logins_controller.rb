class LoginsController < ApplicationController
  
  skip_before_filter :require_login, :only => [:new, :create]
  
  # GET /logins
  # GET /logins.json
  def index
    @logins = Login.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logins }
    end
  end

  # GET /logins/1
  # GET /logins/1.json
  def show
    @login = Login.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @login }
    end
  end

  # GET /logins/new
  # GET /logins/new.json
  def new
    @login = Login.new
    
    if session[:current_user_id] != nil
      redirect_to root_url
      return
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @login }
    end
  end

  # GET /logins/1/edit
  def edit
    @login = Login.find(params[:id])
  end

  
  def authenticate(login)
    # Digest::SHA1.hexdigest(password) ==
    return User.first(:conditions => "cpf = '#{login.cpf}' and senha = '#{login.senha}'")
  end
  
  
  # "Cria" um login, ou seja, "loga o usuário"
  def create
    login=Login.new(params[:login])
    if user = authenticate(login) and user.status == 1
      flash[:notice] = "Voce entrou no sistema"
      # Registra o ID do usuário na sessão para que possa ser recuperado durante outras requisições
      session[:current_user_id] = user.id
      
      log = LogGeral.new
      log.data=DateTime.now
      log.tipolog=1
      log.user=user.id
      log.save
      
      redirect_to root_url
    else
      if(user != nil)
        case user.status
        when 2
          flash[:notice] = "Cadastro bloqueado"
        when 3
          flash[:notice] = "Cadastro desativado"
        else
          flash[:notice] = "Cadastro bloqueado e desativado"
        end
      else
        flash[:notice] = "Erro no login"
      end
      
      if user = User.find_by_cpf(login.cpf)
        log = LogGeral.new
        log.data=DateTime.now
        log.tipolog=2
        log.user=user.id
        log.save
        
        log = LogGeral.last(:conditions => ["user = :usuario and tipolog = 1",{:usuario => user.id}])
        numero = LogGeral.all(:conditions => ["user = :usuario and tipolog = 2 and data >= :logdata",{:usuario => user.id, :logdata => log.data}]).length
        if numero > 4 and (user.status = 1 or user.status = 3)
          user.status+=1
          user.save
          flash[:notice] = "Usu&aacute;rio bloqueado por errar cinco vezes a senha"
        end
      end
      
      redirect_to new_login_path
    end
  end
  
  # PUT /logins/1
  # PUT /logins/1.json
  def update
    @login = Login.find(params[:id])

    respond_to do |format|
      if @login.update_attributes(params[:login])
        format.html { redirect_to @login, notice: 'Login foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @login.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # Remove o id do usuário da sessão
    session[:current_user_id] = nil
    flash[:notice] = "Voc&ecirc; saiu do sistema"
    redirect_to new_login_path
  end
end
