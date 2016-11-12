class ChangePendantFkToArtistGroups < ActiveRecord::Migration[5.0]
  def change
    add_reference :pendants, :artist_group, index: true, foreign_key: true
  end
end
