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

ActiveRecord::Schema.define(version: 2019_11_21_145139) do

  create_table "inventory_item_conditions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "inventory_item_states", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "condition"
  end

  create_table "inventory_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "location_id", null: false
    t.bigint "inventory_item_state_id", null: false
    t.bigint "inventory_item_condition_id", null: false
    t.integer "quantity"
    t.integer "quantity_warning_threshold"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inventory_item_condition_id"], name: "index_inventory_items_on_inventory_item_condition_id"
    t.index ["inventory_item_state_id"], name: "index_inventory_items_on_inventory_item_state_id"
    t.index ["item_id"], name: "index_inventory_items_on_item_id"
    t.index ["location_id"], name: "index_inventory_items_on_location_id"
  end

  create_table "item_variants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "variant_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_item_variants_on_item_id"
    t.index ["variant_id"], name: "index_item_variants_on_variant_id"
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "sku"
    t.string "name"
    t.text "description"
    t.float "cost"
    t.string "size"
    t.string "manufacturer"
    t.string "type"
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "location_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.bigint "location_type_id", null: false
    t.json "properties"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_type_id"], name: "index_locations_on_location_type_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "variants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "product_id"
    t.text "description"
    t.float "price"
    t.string "size"
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  add_foreign_key "inventory_items", "inventory_item_conditions"
  add_foreign_key "inventory_items", "inventory_item_states"
  add_foreign_key "inventory_items", "items"
  add_foreign_key "inventory_items", "locations"
  add_foreign_key "item_variants", "items"
  add_foreign_key "item_variants", "variants"
  add_foreign_key "locations", "location_types"
  add_foreign_key "variants", "products"
end
