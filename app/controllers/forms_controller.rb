# encoding: utf-8
class FormsController < ApplicationController
  # GET /forms
  def index
    @event = Event.find_by_str_id(params[:event_str_id],:include => {:forms => :fopt_infos})
    @forms = @event.forms
    @fopt_masters = @event.fopt_masters
    @fopt_infos  = Hash.new
    @forms.each do |form|
      form.fopt_infos.each do |info|
        @fopt_infos["#{form.id}_#{info.fopt_master.id}"] = info.value
      end
    end
    @fopt_infos
    p @fopt_infos
  end

  # GET /events/form/:form_str_id
  def show
    @form = Form.find_by_str_id(params[:form_str_id])
    @event_name  = @form.event.name
  end

  # GET /events/:event_str_id/form
  def new
    event = Event.find_by_str_id(params[:event_str_id])
    @form = Form.new
    @event_str_id = event.str_id
    @event_name = event.name
    @action = "create"
    @fopt_masters = event.fopt_masters
  end


  # POST /events/form/:form_str_id
  def create
    @form = Form.new(params[:form])
    str_array = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    form_str_id = ( Array.new(16){ str_array[rand(str_array.size)] } ).join
    @form.str_id = form_str_id
    event = Event.find_by_str_id(params[:event_str_id])
    @form.event_id = event.id
    
    

    if @form.save
        p "success★"
        p @form

        #fopt_infoを登録
        event.fopt_masters.each do |mst|
          fopt_info = FoptInfo.new
          fopt_info.form_id = @form.id
          fopt_info.fopt_master_id = mst.id
          fopt_info.value = params["fopt#{mst.id}"]
          fopt_info.save
        end

        flash[:notice] = "申し込みを受け付けました。"
        redirect_to action: "show", form_str_id: form_str_id
    else
      @event_str_id = params[:event_str_id]
      @event_name = params[:event_name]
      @action = "create"
      render action: "new" 
    end
  end

  # GET /events/form/:form_str_id/edit
  def edit
    @form = Form.find_by_str_id(params[:form_str_id])
    @form_str_id = @form.str_id
    @event_name = @form.event.name
    @action = "update"
  end

  # PUT /events/form/:form_str_id
  def update
    @form = Form.find_by_str_id(params[:form_str_id])

    if @form.update_attributes(params[:form])
      flash[:notice] = "回答を更新しました。"
      redirect_to action: "show", form_str_id: @form.str_id
    else
      @form_str_id = params[:form_str_id]
      @action = "update"
      render action: "edit" 
    end
  end

  # DELETE events/form/:form_str_id/
  def destroy
    @form = Form.find_by_str_id(params[:form_str_id])
    event_str_id = @form.event.str_id
    @form.destroy
    redirect_to action: "index", event_str_id: event_str_id
  end
end
