class FixNailUserIndex < ActiveRecord::Migration[4.2]
  def change
    remove_index :nails, :user_id
    add_index :nails, :user_id
  end
end
