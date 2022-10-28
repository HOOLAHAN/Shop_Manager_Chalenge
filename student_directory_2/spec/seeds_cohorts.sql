TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE;
TRUNCATE TABLE students RESTART IDENTITY CASCADE;

INSERT INTO cohorts (cohort_name, starting_date) VALUES ('October', '01/10/2022');
INSERT INTO cohorts (cohort_name, starting_date) VALUES ('October', '01/10/2022');
INSERT INTO cohorts (cohort_name, starting_date) VALUES ('September', '01/09/2022');
INSERT INTO cohorts (cohort_name, starting_date) VALUES ('September', '01/09/2022');

INSERT INTO students (name, cohort_id) VALUES ('Iain', 1);
INSERT INTO students (name, cohort_id) VALUES ('Joe', 1);
INSERT INTO students (name, cohort_id) VALUES ('Sam', 2);
INSERT INTO students (name, cohort_id) VALUES ('James', 2);
