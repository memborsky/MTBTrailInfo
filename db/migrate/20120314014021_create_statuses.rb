class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :trail_id
      t.integer :level
      t.string :details

      t.timestamps
    end
  end
  def down
    drop_table :statuses
  end
end
