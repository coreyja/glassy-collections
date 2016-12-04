SELECT
  pendants.id as pendant_id,
  pendants.name as term
FROM pendants

UNION

SELECT
  pendants.id as pendant_id,
  artists.name as term
FROM pendants
JOIN artist_artist_groups on pendants.artist_group_id = artist_artist_groups.artist_group_id
JOIN artists on artist_artist_groups.artist_id = artists.id;

