# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150420141941) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "cam_events", force: true do |t|
    t.string   "source"
    t.string   "eventTime"
    t.string   "eventType"
    t.boolean  "acknowledged"
    t.datetime "acknowledged_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connections", force: true do |t|
    t.integer  "stationID"
    t.integer  "logoID"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_commands", force: true do |t|
    t.integer  "deviceType"
    t.string   "command"
    t.integer  "numOfR"
    t.integer  "commandId"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", force: true do |t|
    t.string   "name"
    t.string   "ip_addr"
    t.string   "login"
    t.string   "pass"
    t.integer  "nextID"
    t.integer  "prevID"
    t.integer  "deviceTypeID"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_entries", force: true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "url"
    t.datetime "published_at"
    t.string   "guid"
    t.string   "channel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "icons", force: true do |t|
    t.integer  "width"
    t.integer  "height"
    t.string   "altText"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
  end

  create_table "markers", force: true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lon"
    t.integer  "zoom"
    t.integer  "iconID"
    t.string   "href"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "myroutes", force: true do |t|
    t.string   "name"
    t.integer  "routeId"
    t.integer  "deviceId"
    t.integer  "nextDeviceId"
    t.integer  "prevDeviceId"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oids", force: true do |t|
    t.string   "oid"
    t.integer  "deviceID"
    t.integer  "numRV"
    t.string   "returnType"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "s_samples", force: true do |t|
    t.string   "oid"
    t.string   "s1"
    t.string   "s2"
    t.string   "s3"
    t.string   "s4"
    t.string   "s5"
    t.string   "s6"
    t.string   "s7"
    t.string   "s8"
    t.string   "s9"
    t.string   "s10"
    t.string   "rssi1"
    t.string   "rss2"
    t.string   "lmrv1"
    t.string   "lmrv2"
    t.boolean  "hmu1s"
    t.boolean  "hmu2s"
    t.integer  "numoflinks"
    t.integer  "deviceID"
    t.string   "ipaddr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "samples", force: true do |t|
    t.integer  "routeId"
    t.integer  "prevHBS"
    t.integer  "currentHBS"
    t.integer  "nextHBS"
    t.integer  "hmu1"
    t.integer  "hmu2"
    t.integer  "hmu1_RSSI"
    t.integer  "hmu2_RSSI"
    t.string   "hmu1_HBS"
    t.string   "hmu2_HBS"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hbs1_RX"
    t.integer  "hbs2_RX"
    t.integer  "hmu1_TX"
    t.integer  "hmu2_TX"
  end

  create_table "snmps", force: true do |t|
    t.string   "oid"
    t.string   "s1"
    t.string   "s2"
    t.string   "s3"
    t.string   "s4"
    t.string   "s5"
    t.string   "s6"
    t.string   "s7"
    t.string   "s8"
    t.string   "s9"
    t.string   "s10"
    t.string   "rssi1"
    t.string   "rss2"
    t.string   "lmrv1"
    t.string   "lmrv2"
    t.boolean  "hmu1s"
    t.boolean  "hmu2s"
    t.integer  "numoflinks"
    t.integer  "deviceID"
    t.string   "ipaddr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", force: true do |t|
    t.string   "name"
    t.float    "lan"
    t.float    "lon"
    t.integer  "numOfConnections"
    t.integer  "iconID"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weathers", force: true do |t|
    t.string   "woeid"
    t.string   "tempHigh"
    t.string   "tempLow"
    t.string   "name"
    t.datetime "fordate"
    t.integer  "iconID"
    t.string   "title"
    t.integer  "temp"
    t.text     "condText"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
