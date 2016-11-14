SELECT artist_groups.id AS artist_group_id , array_agg(artist_id) AS artist_ids
FROM artist_groups
JOIN artist_artist_groups ON artist_artist_groups.artist_group_id = artist_groups.id
GROUP BY artist_groups.id;
