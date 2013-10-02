class Event < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :payments
  has_many :paticipants

  def payments_sum
  	self.payments.sum(:price).to_i
  end

  def payments_average
  	(payments_sum / self.paticipants.count).to_i
  end
end
