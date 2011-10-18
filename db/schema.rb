# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111012152719) do

  create_table "billing_entities", :force => true do |t|
    t.string   "name"
    t.string   "branch"
    t.string   "entity_type"
    t.boolean  "active"
    t.string   "billing_format"
    t.string   "clearing_house"
    t.string   "departement"
    t.string   "attn"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.string   "other_info_1"
    t.string   "other_info_2"
    t.string   "other_info_3"
    t.string   "other_info_4"
    t.text     "comment"
    t.integer  "invoice_id"
    t.string   "insurance_plan"
    t.boolean  "mediacare"
    t.boolean  "mediacaid"
    t.boolean  "tricare"
    t.boolean  "champva"
    t.boolean  "healt_plan"
    t.boolean  "black_ling"
    t.boolean  "other"
    t.boolean  "accept_assignment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_recipients", :force => true do |t|
    t.integer  "message_id",                 :null => false
    t.integer  "recipient_id",               :null => false
    t.string   "status",       :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_recipients", ["message_id"], :name => "index_message_recipients_on_message_id"
  add_index "message_recipients", ["recipient_id"], :name => "index_message_recipients_on_recipient_id"
  add_index "message_recipients", ["status"], :name => "index_message_recipients_on_status"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id",                :null => false
    t.text     "message"
    t.string   "status",     :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["message"], :name => "index_messages_on_message"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"
  add_index "messages", ["status"], :name => "index_messages_on_status"

  create_table "patients", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.float    "age"
    t.text     "description"
    t.string   "visit"
    t.string   "primary_contact"
    t.string   "relation"
    t.string   "email"
    t.string   "phone_number"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "suspended"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
