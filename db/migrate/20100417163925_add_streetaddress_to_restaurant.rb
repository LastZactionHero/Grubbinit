class AddStreetaddressToRestaurant < ActiveRecord::Migration
  def self.up
    add_column :restaurants, :streetaddress, :string
  end

  def self.down
    remove_column :restaurants, :streetaddress
  end
end
