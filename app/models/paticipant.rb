class Paticipant < ActiveRecord::Base
  attr_accessible :event_id, :name
  has_many :payments
end
