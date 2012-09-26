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
    session[:current_user_id] = nil
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
    if user = authenticate(login)
      flash[:notice] = "Voce entrou no sistema"
      # Registra o ID do usuário na sessão para que possa ser recuperado durante outras requisições
      session[:current_user_id] = user.id
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  # PUT /logins/1
  # PUT /logins/1.json
  def update
    @login = Login.find(params[:id])

    respond_to do |format|
      if @login.update_attributes(params[:login])
        format.html { redirect_to @login, notice: 'Login was successfully updated.' }
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
    flash[:notice] = "Voce saiu do sistema"
    redirect_to root_url
  end
end