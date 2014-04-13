# encoding: utf-8
class Event < ActiveRecord::Base
  attr_accessible :description, :name, :str_id
  has_many :payments
  has_many :paticipants
  has_many :forms 
  has_many :fopt_masters, order: '"sort_order" asc'
  validates :name, presence: {message: "イベント名を入力してください"}
  

  def payments_sum
  	self.payments.sum(:price).to_i
  end

  def payments_average
    if self.paticipants.count == 0
      0
    else
  	 (payments_sum / self.paticipants.count).to_i
    end
  end

  def sum_payment_of_paticipant(paticipant_id)
  	sum = 0
  	payments.each do |p|
  		sum += p.payment_of_paticipant(paticipant_id)
  	end
  	sum.to_i
  end
end
