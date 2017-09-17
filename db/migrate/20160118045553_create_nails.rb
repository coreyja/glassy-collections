class CreateNails < ActiveRecord::Migration[4.2]
  def change
    create_table :nails do |t|
      t.string :name, null: false
      t.string :description

      t.belongs_to :user, null: false

      t.timestamps null: false
    end
    add_index :nails, :user_id, unique: true
    add_foreign_key :nails, :users
  end
end
