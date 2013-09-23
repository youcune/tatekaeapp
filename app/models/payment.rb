class Payment < ActiveRecord::Base
  attr_accessible :event_id, :name, :paticipant_id, :price
  belongs_to :event 
  belongs_to :paticipant
end
