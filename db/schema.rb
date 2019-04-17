ActiveRecord::Schema.define(version: 2019_04_17_212941) do

  create_table "plays", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "director"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
