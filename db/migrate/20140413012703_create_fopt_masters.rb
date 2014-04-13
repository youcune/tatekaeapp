class CreateFoptMasters < ActiveRecord::Migration
  def change
    create_table :fopt_masters do |t|
      t.integer :event_id
      t.integer :order
      t.string :name
      t.string :value_type
      t.string :choices

      t.timestamps
    end
  end
end
