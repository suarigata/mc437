class UsersController < ApplicationController
  
  skip_before_filter :require_login, :only => [:new, :create, :lembrar_senha, :mostrarDica]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.status = 1
    @user.usertype = 3

    respond_to do |format|
      if @user.save
        
        log = LogGeral.new
        log.data=DateTime.now
        log.tipolog=3
        log.user=@user.id
        log.save
        
        format.html { redirect_to @user, notice: 'Usu&aacute;rio foi salvo com sucesso.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if(params[:usertype] != nil and params[:usertype] != 2)
      params[:sistema] = nil # TODO isso nao funfa
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_url, notice: 'Usuario foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @_current_user.status = 3
    @_current_user.save
    session[:current_user_id] = nil
    flash[:notice] = "Voc&ecirc; desativou sua conta com sucesso."
    redirect_to new_login_path

#    respond_to do |format|
#      format.html { redirect_to users_url }
#      format.json { head :no_content }
#    end
  end
  
  def alter
    if params[:cpf] != nil
      usuario = User.find_by_cpf(params[:cpf])
      if(usuario != nil)
        redirect_to edit_user_path(usuario.id)
      else
        flash[:notice] = "CPF nao consta nos registros"
      end
    end
  end

#  def lembrar_senha
#  end
  def mostrarDica
    usuario = User.find_by_cpf(params[:cpf])
    if(usuario != nil)
      if params[:senha] != nil and params[:resposta_dica] != nil 
        if params[:resposta_dica] == usuario.resposta_dica_senha and params[:senha].length >= 6
          usuario.senha = params[:senha]
          usuario.save
          flash[:notice] = "Senha alterada com sucesso"
          
          log = LogGeral.new
          log.data=DateTime.now
          log.tipolog=6
          log.user=usuario.id
          log.save
          
          redirect_to new_login_path #tela login ou entra logado?
        else
          if params[:senha].length < 6
            flash[:notice] = "Senha deve conter no minimo 6 caracteres"
          else
            flash[:notice] = "Resposta incorreta"
          end 
        end
      end
      @cpf = usuario.cpf
      @dica = usuario.dica_senha
    else
      flash[:notice] = "CPF nao consta nos registros"
      redirect_to users_lembrar_senha_path
    end
  end
  
  def bloqueio
    if params[:cpf] != nil
      usuario = User.find_by_cpf(params[:cpf])
      if(usuario != nil)
        if(usuario.status == 1 or usuario.status == 3)
          usuario.status = usuario.status + 1
          usuario.save
          flash[:notice] = "Usuario bloqueado com sucesso"
          
          log = LogGeral.new
          log.data=DateTime.now
          log.tipolog=4
          log.user=usuario.id
          log.sistema=@_current_user.sistema
          log.save
        end
      else
        flash[:notice] = "CPF nao consta nos registros"
      end
    end
  end
  
  def desbloqueio
    if params[:cpf] != nil
      usuario = User.find_by_cpf(params[:cpf])
      if(usuario != nil)
        if(usuario.status == 2 or usuario.status == 4)
          usuario.status=usuario.status-1
          usuario.save
          flash[:notice] = "Usuario desbloqueado com sucesso"
          
          log = LogGeral.new
          log.data=DateTime.now
          log.tipolog=5
          log.user=usuario.id
          log.sistema=@_current_user.sistema
          log.save
        end
      else
        flash[:notice] = "CPF nao consta nos registros"
      end
    end
  end
  
  def relatorio
    if params[:tipolog] != nil
      
      #@inicial = params[:start_date][:year] + "-" + params[:start_date][:month] + "-" + params[:start_date][:day]
      #@final = params[:end_date][:year] + "-" + params[:end_date][:month] + "-" + params[:end_date][:day]
      #@query = "tipolog = #{params[:tipolog]}" # and data >= #{@inicial} and data <= Datetime('#{@final}')"
      
      #@logs = LogGeral.all(:conditions => "tipolog = #{params[:tipolog]} :start_date..:end_date")
      @logs = LogGeral.all(:conditions => "tipolog = #{params[:tipolog]}")
    end
  end
end