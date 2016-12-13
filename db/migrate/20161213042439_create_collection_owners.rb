class CreateCollectionOwners < ActiveRecord::Migration[5.0]
  def change
    create_table :collection_owners do |t|
      t.belongs_to :collection, foreign_key: true, index: true, null: false
      t.integer :owner_id, null: false
      t.timestamps
    end
    add_foreign_key :collection_owners, :users, column: :owner_id
    add_index :collection_owners, :owner_id
  end
end
