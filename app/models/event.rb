class Event < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :payments
  has_many :paticipants

  def payments_sum
  	self.payments.sum(:price)
  end

  def payments_average
  	p (payments_sum / self.paticipants.count).to_i
  end
end
