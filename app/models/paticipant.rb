class Paticipant < ActiveRecord::Base
  attr_accessible :event_id, :name
  has_many :payments
  belongs_to :event

   def payments_price_sum
  	self.payments.sum(:price).to_i
  end

  def event_payments_price_sum
  	# self.event.payments.sum(:price).to_i
  end
end
