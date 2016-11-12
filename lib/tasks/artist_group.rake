namespace :artist_group do
  desc 'Backfill Pendant Artist Groups, creating new ArtistGroups when necessary'
  task :backfill_pendant_artist_groups => :environment do
    Pendant.where(artist_group: nil).find_each do |pendant|
      pendant.update(artist_group: Artist.where(id: pendant.artist).artist_group)
    end
  end
end
