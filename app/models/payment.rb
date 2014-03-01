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

  def payment_of_paticipant(paticipant_id)
    flg = false
    exemptions.each do |e|
      flg = true if e.paticipant_id == paticipant_id 
    end
    #exemption = Exemption.find(:first,:conditions =>["paticipant_id=? and payment_id=?",paticipant_id,self.id])

    #if exemption != nil
    if flg
      0
    else
      price_per_paticipant
    end
  end
end
