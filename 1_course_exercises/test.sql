SELECT id, title, release_year 
FROM albums 
WHERE release_year > 1980 AND release_year < 1990;

SELECT title, artist_id
FROM albums
WHERE release_year >= 1980 AND release_year <= 1990;

SELECT albums
FROM albums.artist_id
WHERE artist = 'Pixies' AND release_year <= 1990 AND release_year >= 1980;

UPDATE albums
SET release_year = '1972'
WHERE id = '3';

SELECT release_year FROM albums WHERE id = '3';

SELECT *
FROM albums;

SELECT *
FROM artists;

DELETE FROM albums WHERE id = '12';

INSERT INTO albums
  ( title, release_year)
  VALUES( 'Mezzanine', '1998' );

UPDATE albums
SET artist_id = '5'
WHERE id = '13';

INSERT INTO artists 
  (name, genre)
  VALUES('50 Cent', 'RAP');

INSERT INTO albums 
  (title, release_year, artist_id)
  VALUES('Get Rich Or Die Tryin', '2003', '5');

  INSERT INTO movies
	(title, genre, release_year)
	VALUES('Shrek', 'Animation', 2001);

  SELECT albums.id, albums.title, artists.id, artists.name
  FROM albums
    JOIN artists
    ON artists.id = albums.artist_id;


-- Find the album ID, artist ID, album title and artist name of all the albums
SELECT albums.id AS album_id,
       artists.id AS artist_id,
       albums.title,
       artists.name
  FROM artists
    JOIN albums
    ON albums.artist_id = artists.id;

-- Find the album ID, artist ID, album title and artist name of all the albums
-- where the associated artist is ABBA.
-- (in other words, only albums by ABBA).
SELECT albums.id AS album_id,
       artists.id AS artist_id,
       albums.title,
       artists.name
  FROM artists
    JOIN albums
    ON albums.artist_id = artists.id
  WHERE artists.name = 'ABBA';


SELECT 	albums.id,
		albums.title 
FROM albums
JOIN artists
ON albums.artist_id = artists.id
WHERE artists.name = 'Taylor Swift';

SELECT 	albums.id AS album_id,
		albums.title 
FROM albums
JOIN artists
ON albums.artist_id = artists.id
WHERE artists.name = 'Nina Simone'
AND release_year > '1975';



-- Select all the tags associated with a given post.
-- Note how we're using two different joins to "link"
-- all the three tables together:
--    * first, by matching only records in the join table for the given post
--    * second, by matching only tags for these records in the join table
SELECT tags.id, tags.name
  FROM tags 
    JOIN posts_tags ON posts_tags.tag_id = tags.id
    JOIN posts ON posts_tags.post_id = posts.id
    WHERE posts.id = 2;


-- Use a SELECT query with a JOIN to retrieve all the posts associated with the tag 'travel'.
SELECT posts.id, posts.title
  FROM posts
  	JOIN posts_tags ON posts_tags.post_id = posts.id
  	JOIN tags ON posts_tags.tag_id = tags.id	
    WHERE tag_id = 2;

