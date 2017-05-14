SELECT
  glass_art_pieces.id as glass_art_piece_id,
  glass_art_pieces.name as term
FROM glass_art_pieces
WHERE wearable = true

UNION

SELECT
  glass_art_pieces.id as glass_art_piece_id,
  artists.name as term
FROM glass_art_pieces
JOIN artist_artist_groups on glass_art_pieces.artist_group_id = artist_artist_groups.artist_group_id
JOIN artists on artist_artist_groups.artist_id = artists.id
WHERE glass_art_pieces.wearable = true;

