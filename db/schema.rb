# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100417195519) do

  create_table "customers", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drivers", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address"
    t.string   "phone"
    t.datetime "lastclockin"
    t.boolean  "isactive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", :force => true do |t|
    t.string   "name"
    t.string   "restaurant"
    t.string   "price"
    t.integer  "preptime"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
