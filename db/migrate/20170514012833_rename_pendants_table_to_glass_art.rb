class RenamePendantsTableToGlassArt < ActiveRecord::Migration[5.0]
  def change
    rename_table :pendants, :glass_art_pieces
    remove_column :glass_art_pieces, :user_id, :integer
    add_column :glass_art_pieces, :wearable, :boolean, null: false, default: false

    reversible do |dir|
      dir.up do
        execute 'update glass_art_pieces set wearable = true'
      end
      dir.down {}
    end
  end
end
