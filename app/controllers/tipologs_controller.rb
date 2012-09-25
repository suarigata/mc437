class TipologsController < ApplicationController
  # GET /tipologs
  # GET /tipologs.json
  def index
    @tipologs = Tipolog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipologs }
    end
  end

  # GET /tipologs/1
  # GET /tipologs/1.json
  def show
    @tipolog = Tipolog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipolog }
    end
  end

  # GET /tipologs/new
  # GET /tipologs/new.json
  def new
    @tipolog = Tipolog.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipolog }
    end
  end

  # GET /tipologs/1/edit
  def edit
    @tipolog = Tipolog.find(params[:id])
  end

  # POST /tipologs
  # POST /tipologs.json
  def create
    @tipolog = Tipolog.new(params[:tipolog])

    respond_to do |format|
      if @tipolog.save
        format.html { redirect_to @tipolog, notice: 'Tipolog was successfully created.' }
        format.json { render json: @tipolog, status: :created, location: @tipolog }
      else
        format.html { render action: "new" }
        format.json { render json: @tipolog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipologs/1
  # PUT /tipologs/1.json
  def update
    @tipolog = Tipolog.find(params[:id])

    respond_to do |format|
      if @tipolog.update_attributes(params[:tipolog])
        format.html { redirect_to @tipolog, notice: 'Tipolog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipolog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipologs/1
  # DELETE /tipologs/1.json
  def destroy
    @tipolog = Tipolog.find(params[:id])
    @tipolog.destroy

    respond_to do |format|
      format.html { redirect_to tipologs_url }
      format.json { head :no_content }
    end
  end
end
