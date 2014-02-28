# coding: utf-8
class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.includes(:paticipants,:payments)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id],:include => {:payments => :exemptions})
    @notice = params[:notice]
    #p @notice

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def show_by_str_id
  @event = Event.find_by_str_id(params[:str_id],:include => {:payments => :exemptions})
  @notice = params[:notice]
  #p @notice

  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @event }
  end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    str_array = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    random_token = ( Array.new(32){ str_array[rand(str_array.size)] } ).join
    @event.str_id = random_token
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.payments.each do |payment|
      payment.destroy
    end

    @event.paticipants.each do |paticipant|
      paticipant.destroy
    end
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
