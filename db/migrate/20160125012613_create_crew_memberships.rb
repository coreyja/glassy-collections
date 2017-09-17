class CreateCrewMemberships < ActiveRecord::Migration[4.2]
  def change
    create_table :crew_memberships do |t|
      t.references :crew, null: false
      t.references :user, null: false

      t.timestamps null: false
    end
    add_index :crew_memberships, :crew_id
    add_index :crew_memberships, :user_id
    add_index :crew_memberships, [:crew_id, :user_id], unique: true

    add_foreign_key :crew_memberships, :crews
    add_foreign_key :crew_memberships, :users

  end
end
