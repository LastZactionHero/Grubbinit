class AddRestaurantIdToMenuItems < ActiveRecord::Migration
  def self.up
    add_column :menu_items, :restaurant_id, :integer
  end

  def self.down
    remove_column :menu_items, :restaurant_id
  end
end
