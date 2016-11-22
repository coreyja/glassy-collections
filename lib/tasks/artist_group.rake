# frozen_string_literal: true
namespace :artist_group do
  desc 'Backfill Pendant Artist Groups, creating new ArtistGroups when necessary'
  task backfill_pendant_artist_groups: :environment do
    Pendant.where(artist_group: nil).find_each do |pendant|
      artist_group = ArtistGroup.find_or_initialize_by_artist_ids([pendant.artist_id])
      pendant.update!(artist_group: artist_group)
    end
  end
end
