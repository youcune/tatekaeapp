class Exemption < ActiveRecord::Base
  attr_accessible :paticipant_id, :payment_id
  belongs_to :paticipant
  belongs_to :payment
end
