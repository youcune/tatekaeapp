# encoding: utf-8
class Payment < ActiveRecord::Base
  attr_accessible :event_id, :name, :paticipant_id, :price
  belongs_to :event 
  belongs_to :paticipant
  has_many :exemptions

  validates :name, presence: {message: "支払項目名を入力してください"}
  validates :price, presence: {message: "金額を入力してください"}, 
                    numericality: {:only_integer => true, message: "金額は整数で入力してください"}
  

  def payer_num
  	self.event.paticipants.length - self.exemptions.length
  end

  def price_per_paticipant
    if payer_num != 0
  	 self.price / payer_num
    else
      0
    end
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
