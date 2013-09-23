class Event < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :payments
  has_many :paticipants
end
