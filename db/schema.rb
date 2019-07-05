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

ActiveRecord::Schema.define(version: 2019_06_21_021442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "customer_id"
    t.string "customer_name"
    t.string "group_id"
    t.string "city"
    t.string "state"
    t.string "postcode"
    t.string "pricelist"
    t.date "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.string "invoice_id"
    t.string "customer_id"
    t.string "order_id"
    t.string "item_id"
    t.integer "order_qty"
    t.integer "backorder_qty"
    t.integer "shipped_qty"
    t.decimal "unit_price"
    t.decimal "invoice_price"
    t.integer "fiscal_year"
    t.integer "fiscal_month"
    t.date "invoice_date"
    t.string "sales_person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
