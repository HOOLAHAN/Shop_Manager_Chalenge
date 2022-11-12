TRUNCATE TABLE albums RESTART IDENTITY;
TRUNCATE TABLE artists RESTART IDENTITY;

INSERT INTO albums (title, release_year, artist_id) VALUES
('Doolittle', '1989', 1),
('Surfer Rosa', '1988', 1),
('Waterloo', '1974', 2),
('Super Trouper', '1980', 2),
('Bossanova', '1990', 1);

INSERT INTO artists (name, genre) VALUES
('Pixies', 'Rock'),
('ABBA', 'Pop'),
('Taylor Swift', 'Pop'),
('Nina Simone', 'Pop'),
('50 Cent', 'RAP');