class MakePendantArtistGroupIdNonNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :pendants, :artist_group_id, false
  end
end
