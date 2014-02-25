class Payment < ActiveRecord::Base
  attr_accessible :event_id, :name, :paticipant_id, :price
  belongs_to :event 
  belongs_to :paticipant
  has_many :exemptions

  def payer_num
  	self.event.paticipants.length - self.exemptions.length
  end

  def price_per_paticipant
  	self.price / payer_num
  end

  def check_duty_by_user_id(user_id)

    
  end


  def payment_of_paticipant(paticipant_id)
    exemption = Exemption.find(:first,:conditions =>["paticipant_id=? and payment_id=?",paticipant_id,self.id])
    if exemption != nil
      0
    else
      price_per_paticipant
    end
  end
end
