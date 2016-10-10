class DropDabs < ActiveRecord::Migration[5.0]
  def up
    drop_table :dabs
  end

  def down
    create_table "dabs", force: :cascade do |t|
      t.integer  "user_id",                  null: false
      t.integer  "nail_id",                  null: false
      t.integer  "milliseconds",             null: false
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
      t.integer  "rating",       default: 3, null: false
      t.index ["nail_id"], name: "index_dabs_on_nail_id", using: :btree
      t.index ["user_id"], name: "index_dabs_on_user_id", using: :btree
    end

    add_foreign_key "dabs", "nails"
    add_foreign_key "dabs", "users"
  end
end
