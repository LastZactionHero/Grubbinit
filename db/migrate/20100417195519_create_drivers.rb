class CreateDrivers < ActiveRecord::Migration
  def self.up
    create_table :drivers do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :phone
      t.datetime :lastclockin
      t.boolean :isactive

      t.timestamps
    end
  end

  def self.down
    drop_table :drivers
  end
end
