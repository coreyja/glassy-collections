class AddRatingToDab < ActiveRecord::Migration
  def change
    change_table :dabs do |t|
      t.integer :rating, null: false, default: 3
    end
  end
end
