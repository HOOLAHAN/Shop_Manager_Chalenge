TRUNCATE TABLE posts, tags, posts_tags RESTART IDENTITY CASCADE; 
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title) VALUES ('How to use Git');
INSERT INTO posts (title) VALUES ('Ruby classes');
INSERT INTO posts (title) VALUES ('Using IRB');
INSERT INTO posts (title) VALUES ('My weekend in Edinburgh');
INSERT INTO posts (title) VALUES ('The best chocolate cake EVER');
INSERT INTO posts (title) VALUES ('A foodie week in Spain');
INSERT INTO posts (title) VALUES ('SQL basics');


INSERT INTO tags (name) VALUES ('coding');
INSERT INTO tags (name) VALUES ('travel');
INSERT INTO tags (name) VALUES ('cooking');
INSERT INTO tags (name) VALUES ('ruby');
INSERT INTO tags (name) VALUES ('sql');

INSERT INTO posts_tags (post_id, tag_id) VALUES (1, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (2, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (2, 4);
INSERT INTO posts_tags (post_id, tag_id) VALUES (3, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (3, 4);
INSERT INTO posts_tags (post_id, tag_id) VALUES (4, 2);
INSERT INTO posts_tags (post_id, tag_id) VALUES (5, 3);
INSERT INTO posts_tags (post_id, tag_id) VALUES (6, 2);
INSERT INTO posts_tags (post_id, tag_id) VALUES (6, 3);
INSERT INTO posts_tags (post_id, tag_id) VALUES (7, 1);
INSERT INTO posts_tags (post_id, tag_id) VALUES (7, 5);