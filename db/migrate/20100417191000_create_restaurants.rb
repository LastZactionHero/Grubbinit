class CreateRestaurants < ActiveRecord::Migration
  def self.up
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :zipcode
      t.string :phone
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurants
  end
end
