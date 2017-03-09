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

ActiveRecord::Schema.define(version: 20160711211414) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "companies_services", force: :cascade do |t|
    t.integer "company_id"
    t.integer "service_id"
  end

  add_index "companies_services", ["company_id"], name: "index_companies_services_on_company_id"
  add_index "companies_services", ["service_id"], name: "index_companies_services_on_service_id"

  create_table "services", force: :cascade do |t|
    t.string   "service"
    t.float    "price"
    t.integer  "duration"
    t.boolean  "disabled"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
