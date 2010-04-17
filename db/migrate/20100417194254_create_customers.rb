class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :phone
      t.string :email
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
