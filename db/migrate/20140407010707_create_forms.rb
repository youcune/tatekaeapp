class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :str_id
      t.string :name
      t.string :email
      t.integer :event_id

      t.timestamps
    end
  end
end
