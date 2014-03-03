# coding: utf-8
class PaticipantsController < ApplicationController
  # GET /paticipants
  # GET /paticipants.json
  def index
    #@paticipants = Paticipant.all

    
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
    event=Event.find(params[:event_id])
    for  i in 1..params[:num].to_i do
      paticipant = Paticipant.new(event_id: params[:event_id], name: "参加者#{event.paticipants.count+1}")
      paticipant.save
    end
    redirect_to event_path(params[:event_str_id]), notice: "#{params[:num]} Paticipants were successfully updated."
  end

  # POST /
  def create_plural_with_name
    event=Event.find(params[:event_id])
    names_str=params[:paticipants_names].split("\r\n")
    names_str.each do |name_str|
      if(!name_str.blank?)
        Paticipant.new(event_id: params[:event_id], name: name_str).save
      end
    end
    redirect_to event_path(params[:event_str_id]), notice: "#{params[:num]} Paticipants were successfully updated."
  end


  # PUT /paticipants/1
  def update
    @paticipant = Paticipant.find(params[:id])
    if @paticipant.update_attributes(params[:paticipant])
      redirect_to :controller => 'events',:action =>'show',:id=>@paticipant.event.str_id, notice: 'Paticipant was successfully updated.'
    else
      render action: "edit" 
    end
  end

  # DELETE /paticipants/1
  def destroy
    @paticipant = Paticipant.find(params[:id])
    @paticipant.destroy
    redirect_to :controller => 'events',:action =>'show',:id=>@paticipant.event.str_id, notice: 'Paticipant was successfully deleted.'
  end
end
