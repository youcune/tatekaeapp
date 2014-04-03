class AddDispNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :disp_name, :string
  end
end
