# -*- coding: utf-8 -*-
class PaticipantsController < ApplicationController
  # GET /paticipants
  # GET /paticipants.json
  def index
    #@paticipants = Paticipant.all

    puts'aaa'
    
    @paticipants = Paticipant.all
    #@paticipants = Paticipant.all


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
    @paticipant.event_id = params[:event_id]

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
        #format.html { redirect_to @paticipant, notice: 'Paticipant was successfully created.' }
        format.html { redirect_to :controller => 'events',:action =>'show',:id=>@paticipant.event.id, notice: 'Paticipant was successfully added.'}
        format.json { render json: @paticipant, status: :created, location: @paticipant }
      else
        format.html { render action: "new" }
        format.json { render json: @paticipant.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /
  def create_plural
    for  i in 1..params[:num].to_i do
      @paticipant = Paticipant.new
      @paticipant.event_id = params[:event_id]
      @paticipant.name = "参加者#{Event.find(params[:event_id]).paticipants.count+1}"
      #Event.find(params[:event_id]).paticipants.count
      @paticipant.save
    end
    redirect_to :controller => 'events',:action =>'show',:id=>@paticipant.event.id, notice: "#{params[:num]} Paticipants were successfully updated."
    
  end

  # PUT /paticipants/1
  # PUT /paticipants/1.json
  def update
    @paticipant = Paticipant.find(params[:id])

    respond_to do |format|
      if @paticipant.update_attributes(params[:paticipant])
        #format.html { redirect_to @paticipant, notice: 'Paticipant was successfully updated.' }
        format.html { redirect_to :controller => 'events',:action =>'show',:id=>@paticipant.event, notice: 'Paticipant was successfully updated.'}
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
    redirect_to :controller => 'events',:action =>'show',:id=>@paticipant.event.id, notice: 'Paticipant was successfully deleted.'

  end
end
