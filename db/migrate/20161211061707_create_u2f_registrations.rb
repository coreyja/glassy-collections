class CreateU2fRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :u2f_registrations do |t|
      t.belongs_to :users, foreign_key: true, null: false
      t.string :key_handle, null: false
      t.string :public_key, null: false
      t.string :certificate, null: false
      t.integer :counter, null: false
      t.timestamps
    end
  end
end
