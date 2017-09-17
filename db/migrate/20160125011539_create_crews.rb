class CreateCrews < ActiveRecord::Migration[4.2]
  def change
    create_table :crews do |t|
      t.string :name, null: false
      t.references :user, null: false

      t.timestamps null: false
    end
    add_index :crews, :user_id
    add_foreign_key :crews, :users
  end
end
