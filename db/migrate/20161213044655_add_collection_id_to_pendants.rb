class AddCollectionIdToPendants < ActiveRecord::Migration[5.0]
  def change
    add_reference :pendants, :collection, foreign_key: true, index: true, null: true
  end
end
