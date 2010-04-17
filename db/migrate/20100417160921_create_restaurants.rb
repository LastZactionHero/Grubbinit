class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :cuisine
      t.string :starthour
      t.string :endhour

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurants
  end
end
