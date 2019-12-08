# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_06_201239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buylists", force: :cascade do |t|
    t.bigint "printings_id"
    t.text "vendor"
    t.datetime "valid_on"
    t.decimal "price"
    t.integer "quantity"
    t.index ["printings_id", "valid_on", "vendor"], name: "index_buylists_on_printings_id_and_valid_on_and_vendor", unique: true
    t.index ["printings_id"], name: "index_buylists_on_printings_id"
    t.index ["valid_on", "vendor"], name: "index_buylists_on_valid_on_and_vendor"
  end

  create_table "magic_sets", force: :cascade do |t|
    t.text "name"
    t.text "code"
  end

  create_table "printings", force: :cascade do |t|
    t.text "merged_key", null: false
    t.text "scryfall_id"
    t.bigint "magic_set_id"
    t.text "name"
    t.boolean "foil"
    t.text "rarity"
    t.index ["magic_set_id"], name: "index_printings_on_magic_set_id"
    t.index ["merged_key"], name: "index_printings_on_merged_key", unique: true
    t.index ["name"], name: "index_printings_on_name"
  end

end
