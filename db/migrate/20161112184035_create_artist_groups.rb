class CreateArtistGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_groups do |t|

      t.timestamps
    end
  end
end
