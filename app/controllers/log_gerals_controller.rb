class LogGeralsController < ApplicationController
  # GET /log_gerals
  # GET /log_gerals.json
  def index
    @log_gerals = LogGeral.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @log_gerals }
    end
  end

  # GET /log_gerals/1
  # GET /log_gerals/1.json
  def show
    @log_geral = LogGeral.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @log_geral }
    end
  end

  # GET /log_gerals/new
  # GET /log_gerals/new.json
  def new
    @log_geral = LogGeral.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @log_geral }
    end
  end

  # GET /log_gerals/1/edit
  def edit
    @log_geral = LogGeral.find(params[:id])
  end

  # POST /log_gerals
  # POST /log_gerals.json
  def create
    @log_geral = LogGeral.new(params[:log_geral])

    respond_to do |format|
      if @log_geral.save
        format.html { redirect_to @log_geral, notice: 'Log geral was successfully created.' }
        format.json { render json: @log_geral, status: :created, location: @log_geral }
      else
        format.html { render action: "new" }
        format.json { render json: @log_geral.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /log_gerals/1
  # PUT /log_gerals/1.json
  def update
    @log_geral = LogGeral.find(params[:id])

    respond_to do |format|
      if @log_geral.update_attributes(params[:log_geral])
        format.html { redirect_to @log_geral, notice: 'Log geral was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @log_geral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /log_gerals/1
  # DELETE /log_gerals/1.json
  def destroy
    @log_geral = LogGeral.find(params[:id])
    @log_geral.destroy

    respond_to do |format|
      format.html { redirect_to log_gerals_url }
      format.json { head :no_content }
    end
  end
end
