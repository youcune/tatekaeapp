class Paticipant < ActiveRecord::Base
  attr_accessible :event_id, :name
  has_many :payments
  has_many :exemptions
  belongs_to :event

  def payments_price_sum
  	self.payments.sum(:price).to_i
  end

  def event_payments_price_sum
  	# self.event.payments.sum(:price).to_i
  end

  def check_payment_exemption?(payment_id)
    
    flg = false
    self.exemptions.each do |e|
      flg = true if e.payment_id == payment_id 
    end


    if flg then
      return false
    else
      return true
    end 
  end


end
