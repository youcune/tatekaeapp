class FoptMastersController < ApplicationController
  # GET /fopt_masters
  # GET /fopt_masters.json
  def index
    @fopt_masters = FoptMaster.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fopt_masters }
    end
  end

  # GET /fopt_masters/1
  # GET /fopt_masters/1.json
  def show
    @fopt_master = FoptMaster.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fopt_master }
    end
  end

  # GET /fopt_masters/new
  # GET /fopt_masters/new.json
  def new
    @fopt_master = FoptMaster.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fopt_master }
    end
  end

  # GET /fopt_masters/1/edit
  def edit
    @fopt_master = FoptMaster.find(params[:id])
  end

  # POST /fopt_masters
  # POST /fopt_masters.json
  def create
    @fopt_master = FoptMaster.new(params[:fopt_master])

    respond_to do |format|
      if @fopt_master.save
        format.html { redirect_to @fopt_master, notice: 'Fopt master was successfully created.' }
        format.json { render json: @fopt_master, status: :created, location: @fopt_master }
      else
        format.html { render action: "new" }
        format.json { render json: @fopt_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fopt_masters/1
  # PUT /fopt_masters/1.json
  def update
    @fopt_master = FoptMaster.find(params[:id])

    respond_to do |format|
      if @fopt_master.update_attributes(params[:fopt_master])
        format.html { redirect_to @fopt_master, notice: 'Fopt master was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @fopt_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fopt_masters/1
  # DELETE /fopt_masters/1.json
  def destroy
    @fopt_master = FoptMaster.find(params[:id])
    @fopt_master.destroy

    respond_to do |format|
      format.html { redirect_to fopt_masters_url }
      format.json { head :no_content }
    end
  end
end
