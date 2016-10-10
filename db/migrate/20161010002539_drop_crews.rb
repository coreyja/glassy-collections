class DropCrews < ActiveRecord::Migration[5.0]
  def up
    drop_table :crews
  end

  def down
    create_table "crews", force: :cascade do |t|
      t.string   "name",       null: false
      t.integer  "user_id",    null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_crews_on_user_id", using: :btree
    end

    add_foreign_key "crews", "users"
  end
end
