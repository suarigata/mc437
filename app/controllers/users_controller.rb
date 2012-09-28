class UsersController < ApplicationController
  
  skip_before_filter :require_login, :only => [:new, :create]
  
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

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Usu&aacute;rio foi atualizado com sucesso.' }
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
        flash[:notice] = "CPF n&atilde;o consta nos registros"
      end
    end
  end
end