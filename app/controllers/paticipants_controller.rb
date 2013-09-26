class PaticipantsController < ApplicationController
  # GET /paticipants
  # GET /paticipants.json
  def index
    #@paticipants = Paticipant.all


    @paticipants = Paticipant.includes(:payments)
    #@paticipants = Paticipant.all

    @results =[]
    
    @paticipants.each do |paticipant|
      p paticipant

      @result ={}
      @result.store(:paticipant,paticipant)
      @result.store(:sum,paticipant.payments.sum(:price).to_i)
      @results.push @result

      p paticipant.payments.sum(:price).to_i

    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paticipants }
    end
  end

  # GET /paticipants/1
  # GET /paticipants/1.json
  def show
    @paticipant = Paticipant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paticipant }
    end
  end

  # GET /paticipants/new
  # GET /paticipants/new.json
  def new
    @paticipant = Paticipant.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paticipant }
    end
  end

  # GET /paticipants/1/edit
  def edit
    @paticipant = Paticipant.find(params[:id])
  end

  # POST /paticipants
  # POST /paticipants.json
  def create
    @paticipant = Paticipant.new(params[:paticipant])

    respond_to do |format|
      if @paticipant.save
        format.html { redirect_to @paticipant, notice: 'Paticipant was successfully created.' }
        format.json { render json: @paticipant, status: :created, location: @paticipant }
      else
        format.html { render action: "new" }
        format.json { render json: @paticipant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paticipants/1
  # PUT /paticipants/1.json
  def update
    @paticipant = Paticipant.find(params[:id])

    respond_to do |format|
      if @paticipant.update_attributes(params[:paticipant])
        format.html { redirect_to @paticipant, notice: 'Paticipant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paticipant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paticipants/1
  # DELETE /paticipants/1.json
  def destroy
    @paticipant = Paticipant.find(params[:id])
    @paticipant.destroy

    respond_to do |format|
      format.html { redirect_to paticipants_url }
      format.json { head :no_content }
    end
  end
end
