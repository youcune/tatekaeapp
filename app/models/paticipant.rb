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

  def check_payment_by_id(payment_id)
    @exemption = Exemption.find(:first,:conditions =>["paticipant_id=? and payment_id=?",self.id,payment_id])
    if @exemption ==nil then
      return true
    else
      return false
    end 
  end
end
