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