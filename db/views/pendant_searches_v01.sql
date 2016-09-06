SELECT
  pendants.id as pendant_id,
  pendants.name as term
FROM pendants

UNION

SELECT
  pendants.id as pendant_id,
  artists.name as term
FROM pendants
  JOIN artists on pendants.artist_id = artists.id;
