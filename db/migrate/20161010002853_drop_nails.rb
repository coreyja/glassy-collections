class DropNails < ActiveRecord::Migration[5.0]
  def up
    drop_table :nails
  end

  def down
    create_table "nails", force: :cascade do |t|
      t.string   "name",        null: false
      t.string   "description"
      t.integer  "user_id",     null: false
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
      t.index ["user_id"], name: "index_nails_on_user_id", using: :btree
    end

    add_foreign_key "nails", "users"
  end
end
