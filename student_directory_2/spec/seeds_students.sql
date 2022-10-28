TRUNCATE TABLE students RESTART IDENTITY

INSERT INTO students (name, cohort_id) VALUES
('Iain', 1),
('Joe', 1),
('Sam', 2),
('James', 2);