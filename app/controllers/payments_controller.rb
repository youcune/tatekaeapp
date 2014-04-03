# coding: utf-8
class PaymentsController < ApplicationController
  # GET /payments
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  def show
    @payment = Payment.find(params[:id]).includes(:exemption)
    @paticipants = Paticipant.find_all_by_event_id(@payment.event_id)
  end

  # GET /payments/new
  def new
    event = Event.find(params[:event_id])
    @payment = Payment.new
    @payment.event_id = event.id
    @paticipants = event.paticipants
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id],include: :exemptions)
    @payment.price = @payment.price.to_i
    @paticipants = Paticipant.find_all_by_event_id(@payment.event_id,include: :exemptions)
  end

  # POST /payments
  def create
    @payment = Payment.new(params[:payment])
    if @payment.save
      flash[:notice] = "支払項目が登録されました。"
      redirect_to :controller => 'events',:action =>'show',:id=>@payment.event.str_id
    else
      render action: "new"       
    end
  end

  # PUT /payments/1
  def update
    #paymentを更新
    @payment = Payment.find(params[:id])
    @paticipants = @payment.event.paticipants

    ActiveRecord::Base.transaction do
      #paitcipantごとに処理を行う
        @paticipants.each do |paticipant|
        #処理用に指定payment、paticipantごとのexemptionを検索する
        exemption = Exemption.find(:first,
            :conditions =>["paticipant_id=? and payment_id=?",paticipant.id,@payment.id])

        #exemptionチェックが1個も無いとparams[:check_payment] がnilになり
        #params[:check_payment][:"#{paticipant.id}"]が取得できないので、その場合はｎｉｌを設定する
        if params[:check_payment] == nil
          param_check =nil
        else
          param_check = params[:check_payment][:"#{paticipant.id}"]
        end

        if param_check == nil
          #チェックされていない場合(=支払を行なわない・免除(exemption)がある人)：データがある状態が正しい
          #既存のexemptionデータがない場合、データを登録する
          if exemption ==nil 
            exemption  = Exemption.new(paticipant_id:paticipant.id,payment_id:@payment.id)
            exemption.save!
          end  
          #既存のexemptionデータがある場合、何も行わない
        else
          #チェックされている(支払を行う人)場合：データがない状態が正しい
          #既存のexemptionデータがある場合、exemptionを削除する
          if exemption !=nil 
            exemption.destroy!
          end  
          #既存のexemptionデータがない場合、何も行わない
        end
      end
      @payment.update_attributes!(params[:payment])
    end
      flash[:notice] = "支払項目が更新されました。"
      redirect_to :controller => 'events',:action =>'show',:id=>@payment.event.str_id
    rescue
      render action: "edit" 
  end

  # DELETE /payments/1
  def destroy
    payment = Payment.find(params[:id])
    payment.destroy
    flash[:notice] = "支払項目が削除されました。"
    redirect_to :controller => 'events',:action =>'show',:id=>payment.event.str_id
  end

end

