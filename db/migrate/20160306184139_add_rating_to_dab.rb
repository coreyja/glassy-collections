class AddRatingToDab < ActiveRecord::Migration[4.2]
  def change
    change_table :dabs do |t|
      t.integer :rating, null: false, default: 3
    end
  end
end
