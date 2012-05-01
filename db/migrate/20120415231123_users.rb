class Users < ActiveRecord::Migration
  def up
      create_table :users do |t|
        t.string :name
        t.string :rpx_identifier
        t.boolean :admin
    end
  end

  def down
    drop_table :users
  end
end
