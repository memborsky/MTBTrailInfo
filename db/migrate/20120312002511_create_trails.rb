class CreateTrails < ActiveRecord::Migration

  def up
    create_table :trails do |t|
        t.string :name
        t.string :description
          t.text :emergencyinfo
        
        t.timestamps
    end
  end

  def down
    drop_table :trails
  end
end

