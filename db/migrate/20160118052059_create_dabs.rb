class CreateDabs < ActiveRecord::Migration
  def change
    create_table :dabs do |t|
      t.belongs_to :user, null: false
      t.belongs_to :nail, null: false

      t.integer :milliseconds, null: false

      t.timestamps null: false
    end
    add_index :dabs, :user_id
    add_foreign_key :dabs, :users

    add_index :dabs, :nail_id
    add_foreign_key :dabs, :nails
  end
end
