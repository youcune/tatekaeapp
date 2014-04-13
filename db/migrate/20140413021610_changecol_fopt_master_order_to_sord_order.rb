class ChangecolFoptMasterOrderToSordOrder < ActiveRecord::Migration
  def change
  	rename_column :fopt_masters, :order, :sort_order
  end

end
