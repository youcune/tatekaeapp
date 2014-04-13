class FoptMaster < ActiveRecord::Base
  attr_accessible :choices, :event_id, :name, :sort_order, :value_type
  belongs_to :event
  has_many :fopt_infos
end
