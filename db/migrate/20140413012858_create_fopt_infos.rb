class CreateFoptInfos < ActiveRecord::Migration
  def change
    create_table :fopt_infos do |t|
      t.integer :form_id
      t.integer :fopt_master_id
      t.string :value

      t.timestamps
    end
  end
end
