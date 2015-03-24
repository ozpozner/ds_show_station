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

ActiveRecord::Schema.define(version: 20150324175014) do

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

  create_table "myroutes", force: true do |t|
    t.string   "name"
    t.integer  "routeId"
    t.integer  "deviceId"
    t.integer  "nextDeviceId"
    t.integer  "prevDeviceId"
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
    t.float    "hmu1_DATA"
    t.float    "hmu2_DATA"
    t.string   "hmu1_HBS"
    t.string   "hmu2_HBS"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
