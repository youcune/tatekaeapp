class CreateExemptions < ActiveRecord::Migration
  def change
    create_table :exemptions do |t|
      t.integer :paticipant_id
      t.integer :payment_id

      t.timestamps
    end
  end
end
