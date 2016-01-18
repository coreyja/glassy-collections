class FixNailUserIndex < ActiveRecord::Migration
  def change
    remove_index :nails, :user_id
    add_index :nails, :user_id
  end
end
