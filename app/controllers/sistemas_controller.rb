class SistemasController < ApplicationController
  # GET /sistemas
  # GET /sistemas.json
  def index
    @sistemas = Sistema.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sistemas }
    end
  end

  # GET /sistemas/1
  # GET /sistemas/1.json
  def show
    @sistema = Sistema.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sistema }
    end
  end

  # GET /sistemas/new
  # GET /sistemas/new.json
  def new
    @sistema = Sistema.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sistema }
    end
  end

  # GET /sistemas/1/edit
  def edit
    @sistema = Sistema.find(params[:id])
  end

  # POST /sistemas
  # POST /sistemas.json
  def create
    @sistema = Sistema.new(params[:sistema])

    respond_to do |format|
      if @sistema.save
        format.html { redirect_to @sistema, notice: 'Sistema foi salvo com sucesso.' }
        format.json { render json: @sistema, status: :created, location: @sistema }
      else
        format.html { render action: "new" }
        format.json { render json: @sistema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sistemas/1
  # PUT /sistemas/1.json
  def update
    @sistema = Sistema.find(params[:id])

    respond_to do |format|
      if @sistema.update_attributes(params[:sistema])
        format.html { redirect_to @sistema, notice: 'Sistema foi atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sistema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sistemas/1
  # DELETE /sistemas/1.json
  def destroy
    @sistema = Sistema.find(params[:id])
    @sistema.destroy

    respond_to do |format|
      format.html { redirect_to sistemas_url }
      format.json { head :no_content }
    end
  end
end
