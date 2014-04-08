# coding: utf-8
class EventsController < ApplicationController

  # GET /events/
  def index
    
  end

  # GET /events/1
  def show
    @event = Event.find_by_str_id(params[:id],:include => {:payments => :exemptions})
    @url = request.url                  
  end


  # GET /events/new
  def new
    @event = Event.new

  end

  # GET /events/1/edit
  def edit
    @event = Event.find_by_str_id(params[:id])
  end

  # POST /events
  def create
    @event = Event.new(params[:event])
    str_array = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    random_token = ( Array.new(16){ str_array[rand(str_array.size)] } ).join
    @event.str_id = random_token
    if @event.save
      flash[:notice] = "イベントが登録されました。"
      redirect_to event_path(@event.str_id)
    else
      render action: "new" 
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      flash[:notice] = "イベントが更新されました。"
      redirect_to event_path(@event.str_id)
    else
      render action: "edit" 
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    event = Event.find(params[:id])
    event.payments.each do |payment|
      payment.destroy
    end

    event.paticipants.each do |paticipant|
      paticipant.destroy
    end
    event.destroy
    flash[:notice] = "イベントが削除されました。"
    redirect_to events_url
  end
end
