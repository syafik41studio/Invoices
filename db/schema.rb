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

ActiveRecord::Schema.define(:version => 20120119005016) do

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

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contacts", :force => true do |t|
    t.integer  "entity_id"
    t.string   "entity_type"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "middleinitial"
    t.string   "email"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "homephone"
    t.string   "workphone"
    t.string   "cellphone"
    t.string   "fax"
    t.string   "prefcontactmethod"
    t.string   "gender"
    t.date     "contactsince"
    t.date     "logininfosenton"
    t.string   "comments"
    t.boolean  "isprimary"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "relatedas"
    t.string   "disposition"
    t.date     "lastcommunicatedon"
  end

  add_index "contacts", ["entity_id", "entity_type"], :name => "index_contacts_on_entity_id_and_entity_type"

  create_table "conversation_flags", :force => true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversation_flags", ["conversation_id"], :name => "index_conversation_flags_on_conversation_id"
  add_index "conversation_flags", ["status"], :name => "index_conversation_flags_on_status"
  add_index "conversation_flags", ["user_id"], :name => "index_conversation_flags_on_user_id"

  create_table "conversations", :force => true do |t|
    t.integer  "member_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followers", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "following_id"
    t.datetime "follow_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holiday_observeds", :force => true do |t|
    t.integer  "profile_id"
    t.date     "holiday_date"
    t.string   "holiday_name"
    t.string   "holiday_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_conversations", :force => true do |t|
    t.integer  "conversation_id",      :null => false
    t.integer  "sender_id",            :null => false
    t.integer  "recipient_id",         :null => false
    t.text     "body",                 :null => false
    t.string   "status_for_sender"
    t.string   "status_for_recipient"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "message_token"
  end

  add_index "message_conversations", ["body"], :name => "index_message_conversations_on_body"
  add_index "message_conversations", ["conversation_id"], :name => "index_message_conversations_on_conversation_id"
  add_index "message_conversations", ["message_token"], :name => "index_message_conversations_on_message_token"
  add_index "message_conversations", ["recipient_id"], :name => "index_message_conversations_on_recipient_id"
  add_index "message_conversations", ["sender_id"], :name => "index_message_conversations_on_sender_id"
  add_index "message_conversations", ["status_for_recipient"], :name => "index_message_conversations_on_status_for_recipient"
  add_index "message_conversations", ["status_for_sender"], :name => "index_message_conversations_on_status_for_sender"

  create_table "patients", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.float    "age"
    t.text     "description"
    t.string   "visits"
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

  create_table "post_categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_categories", ["parent_id"], :name => "index_post_categories_on_parent_id"
  add_index "post_categories", ["user_id"], :name => "index_post_categories_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "status"
    t.integer  "total_comment"
    t.datetime "last_commented"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "total_like",     :default => 0
  end

  add_index "posts", ["slug"], :name => "index_posts_on_slug", :unique => true

  create_table "posts_with_categories", :id => false, :force => true do |t|
    t.integer "post_id"
    t.integer "category_id"
  end

  create_table "profiles", :force => true do |t|
    t.string   "speciality"
    t.string   "gender"
    t.string   "languages"
    t.string   "accepting_new_patient"
    t.text     "about_me"
    t.text     "biography"
    t.text     "practice"
    t.text     "training_and_cert"
    t.string   "work_phone"
    t.string   "ext"
    t.string   "work_cell_phone"
    t.string   "work_fax_number"
    t.string   "email_address"
    t.string   "office_address"
    t.string   "office_address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "working_hours"
    t.string   "prefered_contact_method"
    t.boolean  "speciality_pv",              :default => false
    t.boolean  "gender_pv",                  :default => false
    t.boolean  "languages_pv",               :default => false
    t.boolean  "accepting_new_patient_pv",   :default => false
    t.boolean  "about_me_pv",                :default => false
    t.boolean  "biography_pv",               :default => false
    t.boolean  "practice_pv",                :default => false
    t.boolean  "training_and_cert_pv",       :default => false
    t.boolean  "work_phone_pv",              :default => false
    t.boolean  "ext_pv",                     :default => false
    t.boolean  "work_cell_phone_pv",         :default => false
    t.boolean  "work_fax_number_pv",         :default => false
    t.boolean  "email_address_pv",           :default => false
    t.boolean  "office_address_pv",          :default => false
    t.boolean  "office_addresss_2_pv",       :default => false
    t.boolean  "city_pv",                    :default => false
    t.boolean  "state_pv",                   :default => false
    t.boolean  "zip_pv",                     :default => false
    t.boolean  "working_hours_pv",           :default => false
    t.boolean  "prefered_contact_method_pv", :default => false
    t.boolean  "holiday_observed_pv",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "description"
    t.boolean  "description_pv",             :default => false
    t.string   "avatar_file_name"
    t.integer  "avatar_file_size"
    t.string   "avatar_content_type"
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

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "timezone"
    t.string   "slug"
    t.string   "full_name"
    t.integer  "like_count"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
