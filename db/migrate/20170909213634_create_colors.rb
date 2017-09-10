class CreateColors < ActiveRecord::Migration[5.0]
  def change
    create_table :colors do |t|
      t.string :name, null: false
      t.references :artist_group, null: false, index: true, foreign_key: true

      t.timestamps
    end
    create_table :glass_art_piece_colors do |t|
      t.references :glass_art_piece, null: false, index: true, foreign_key: true
      t.references :color, null: false, index: true, foreign_key: true
      t.index [:glass_art_piece_id, :color_id], unique: true
    end
  end
end
