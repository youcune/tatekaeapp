class Payment < ActiveRecord::Base
  attr_accessible :event_id, :name, :paticipant_id, :price
  belongs_to :event 
  belongs_to :paticipant
  has_many :exemptions

  def payer_num
  	self.event.paticipants.length - self.exemptions.group("payment_id,paticipant_id").length
  end

  def price_per_paticipant
  	self.price / payer_num
  end
end
