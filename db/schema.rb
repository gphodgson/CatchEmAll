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

ActiveRecord::Schema.define(version: 2020_10_08_035631) do

  create_table "encounters", force: :cascade do |t|
    t.integer "pokemons_id", null: false
    t.integer "locations_id", null: false
    t.decimal "chance"
    t.string "method"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["locations_id"], name: "index_encounters_on_locations_id"
    t.index ["pokemons_id"], name: "index_encounters_on_pokemons_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.text "img"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name"
    t.integer "pokedex_number"
    t.text "thumb"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "img"
    t.string "color"
    t.text "alt_name"
    t.integer "weight"
    t.text "description"
  end

  create_table "stats", force: :cascade do |t|
    t.integer "pokemon_id", null: false
    t.integer "hp"
    t.integer "attack"
    t.integer "defense"
    t.integer "special_attack"
    t.integer "special_defense"
    t.integer "speed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pokemon_id"], name: "index_stats_on_pokemon_id"
  end

  add_foreign_key "encounters", "locations", column: "locations_id"
  add_foreign_key "encounters", "pokemons", column: "pokemons_id"
  add_foreign_key "stats", "pokemons"
end
