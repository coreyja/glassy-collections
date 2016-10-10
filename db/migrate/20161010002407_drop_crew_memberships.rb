class DropCrewMemberships < ActiveRecord::Migration[5.0]
  def up
    drop_table :crew_memberships
  end

  def down
    create_table "crew_memberships", force: :cascade do |t|
      t.integer  "crew_id",    null: false
      t.integer  "user_id",    null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["crew_id", "user_id"], name: "index_crew_memberships_on_crew_id_and_user_id", unique: true, using: :btree
      t.index ["crew_id"], name: "index_crew_memberships_on_crew_id", using: :btree
      t.index ["user_id"], name: "index_crew_memberships_on_user_id", using: :btree
    end

    add_foreign_key "crew_memberships", "crews"
    add_foreign_key "crew_memberships", "users"
  end
end
