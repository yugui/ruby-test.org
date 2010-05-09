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

ActiveRecord::Schema.define(:version => 20100509111943) do

  create_table "bundle_derivations", :force => true do |t|
    t.integer "from_id", :null => false
    t.integer "to_id",   :null => false
  end

  create_table "bundles", :force => true do |t|
    t.string  "signature",   :null => false
    t.text    "name",        :null => false
    t.integer "revision_id", :null => false
  end

  create_table "bundlings", :force => true do |t|
    t.integer "of_id", :null => false
    t.integer "in_id", :null => false
  end

  create_table "part_derivations", :force => true do |t|
    t.integer "from_id", :null => false
    t.integer "to_id",   :null => false
  end

  create_table "parts", :force => true do |t|
    t.string  "identifier",           :null => false
    t.text    "name",                 :null => false
    t.integer "first_appeared_at_id", :null => false
  end

  create_table "platforms", :force => true do |t|
    t.string "arch", :null => false
    t.string "os",   :null => false
    t.string "misc"
  end

  create_table "reports", :force => true do |t|
    t.integer  "site_id",     :null => false
    t.integer  "revision_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "revisions", :force => true do |t|
    t.string   "identifier",   :null => false
    t.datetime "committed_at", :null => false
  end

  create_table "sites", :force => true do |t|
    t.integer  "platform_id", :null => false
    t.integer  "owner_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
