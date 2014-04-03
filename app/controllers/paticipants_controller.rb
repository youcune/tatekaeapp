# coding: utf-8
class PaticipantsController < ApplicationController
  # GET /paticipants
  def index
    @paticipants = Paticipant.all
  end

  # GET /paticipants/1
  def show
    @paticipant = Paticipant.find(params[:id])
  end

  # GET /paticipants/new
  def new
    @paticipant = Paticipant.new
    @paticipant.event_id = params[:event_id]
  end

  # GET /paticipants/1/edit
  def edit
    @paticipant = Paticipant.find(params[:id])
  end

  # POST /paticipants
  # POST /paticipants.json
  def create
    @paticipant = Paticipant.new(params[:paticipant])
    if @paticipant.save
      flash[:notice] = "参加者が登録されました。"
      redirect_to :controller => 'events',:action =>'show',:id=>@paticipant.event.id
    else
      render action: "new"
      
    end
  end

  # POST /
  def create_plural
    event=Event.find(params[:event_id])
    for  i in 1..params[:num].to_i do
      paticipant = Paticipant.new(event_id: params[:event_id], name: "参加者#{event.paticipants.count+1}")
      paticipant.save
    end
    redirect_to event_path(params[:event_str_id]), 
      notice: "参加者が登録されました。"
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
    redirect_to event_path(params[:event_str_id]), 
      notice: "参加者が登録されました。"
  end


  # PUT /paticipants/1
  def update
    @paticipant = Paticipant.find(params[:id])
    if @paticipant.update_attributes(params[:paticipant])
      flash[:notice] = "参加者が更新されました。"
      redirect_to :controller => 'events',:action =>'show',
        :id=>@paticipant.event.str_id
    else
      render action: "edit" 
    end
  end

  # DELETE /paticipants/1
  def destroy
    paticipant = Paticipant.find(params[:id])
    paticipant.exemptions.each do |exemption|
      exemption.destroy
    end
    paticipant.destroy
    flash[:notice] = "参加者が削除されました。"
    redirect_to :controller => 'events',:action =>'show',:id=>paticipant.event.str_id
  end
  # GET /events/1/paticipants
  def show_to_delete
    event=Event.find_by_str_id(params[:str_id])
    @paticipants = event.paticipants
    @event_str_id=event.str_id
  end

  # POST /events/1/paticipnats
  def delete_multiple
    check_values = params[:delete_check]
    event_str_id = params[:event_str_id]
    p event_str_id
    if check_values != nil 
      check_values.each do |check_value|
        Paticipant.find(check_value[0]).destroy
      end
      flash[:notice] = "参加者が削除されました。"
    end
    redirect_to :controller => 'events',:action =>'show', id:event_str_id
  end
end
