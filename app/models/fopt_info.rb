class FoptInfo < ActiveRecord::Base
  attr_accessible :fopt_master_id, :form_id, :value
  belongs_to :form
  belongs_to :fopt_master
end
