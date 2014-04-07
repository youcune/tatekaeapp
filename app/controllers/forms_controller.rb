# encoding: utf-8
class FormsController < ApplicationController
  # GET /forms
  # GET /forms.json
  def index
    @event = Event.find_by_str_id(params[:event_str_id])
    @forms = @event.forms
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
  end


  # POST /events/form/:form_str_id
  def create
    @form = Form.new(params[:form])
    str_array = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    random_token = ( Array.new(16){ str_array[rand(str_array.size)] } ).join
    @form.str_id = random_token
    @form.event_id = Event.find_by_str_id(params[:event_str_id]).id
    p @form

    if @form.save
        flash[:notice] = "申し込みを受け付けました。"
        redirect_to action: "show", form_str_id: random_token
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
