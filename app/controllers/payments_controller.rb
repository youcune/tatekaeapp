# coding: utf-8
class PaymentsController < ApplicationController
  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
    @payment = Payment.find(params[:id]).includes(:exemption)
    @paticipants = Paticipant.find_all_by_event_id(@payment.event_id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.json
  def new
    @payment = Payment.new
    @payment.event_id = params[:event_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @payment }
    end
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id],include: :exemptions)
    @paticipants = Paticipant.find_all_by_event_id(@payment.event_id,include: :exemptions)
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(params[:payment])

    respond_to do |format|
      if @payment.save
        format.html { redirect_to :controller => 'events',:action =>'show',:id=>@payment.event.str_id, notice: 'Payment was successfully added.' }
        format.json { render json: @payment, status: :created, location: @payment }
      else
        format.html { render action: "new" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /payments/1
  # PUT /payments/1.json
  def update
    #paymentを更新
    @payment = Payment.find(params[:id])

    @paticipants = @payment.event.paticipants

    #paitcipantごとに処理を行う
    @paticipants.each do |paticipant|
      p '**********************'
      p paticipant.id
      #処理用に指定payment、paticipantごとのexemptionを検索する
      @exemption = Exemption.find(:first,:conditions =>["paticipant_id=? and payment_id=?",paticipant.id,@payment.id])
      p @exemption
      p params[:check_payment][:"#{paticipant.id}"]
      if params[:check_payment][:"#{paticipant.id}"] == nil
        #チェックされていない場合(=支払を行なわない・免除(exemption)がある人)：データがある状態が正しい
        #既存のexemptionデータがない場合、データを登録する
        p "checked"
        if @exemption ==nil 
          @exemption  = Exemption.new(paticipant_id:paticipant.id,payment_id:@payment.id)
          p @exemption 
          p "saved"
          @exemption.save
        end  
        #既存のexemptionデータがあるい場合、データを登録する
            
      else
        #チェックされている(支払を行う人)場合：データがない状態が正しい
        p "no check"
        #既存のexemptionデータがある場合、exemptionを削除する
        if @exemption !=nil 
          p @exemption 
          @exemption.destroy
          p "desctoryed"
        end  
        #既存のexemptionデータがない場合、何も行わない
      end
    end

    
    if @check_payments != nil
      @check_payments.each do | check_payment_id |
       
      end 
    end


    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        #format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.html { redirect_to :controller => 'events',:action =>'show',:id=>@payment.event.str_id, notice: 'Payment was successfully updated.'}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    redirect_to :controller => 'events',:action =>'show',:id=>@payment.event.str_id, notice: 'Payment was successfully deleted.'
  end
end
