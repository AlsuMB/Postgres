CREATE TABLE task_1_1
(
    content VARCHAR(4000)
);
CREATE TABLE task_1_2
(
    content VARCHAR(4000)
);
CREATE TABLE task_1_3
(
    content VARCHAR(4000)
);
CREATE TABLE task_1_4
(
    content VARCHAR(4000)
);

ALTER TABLE task_1_1
ALTER COLUMN content
SET STORAGE PLAIN;

ALTER TABLE task_1_2
ALTER COLUMN content
SET STORAGE EXTENDED;

ALTER TABLE task_1_3
ALTER COLUMN content
SET STORAGE EXTERNAL;

ALTER TABLE task_1_4
ALTER COLUMN content
SET STORAGE MAIN;

DO $$
BEGIN
FOR i in 1..100
    LOOP
    INSERT INTO task_1_4 VALUES (array_to_string(array(select substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',((random()*(36-1)+1)::integer),1) from generate_series(1,3653)),''));
    end loop;
end $$;

-- Pgbench script
begin;
    SELECT * FROM task_1_1;
    SELECT * FROM task_1_2;
    SELECT * FROM task_1_3;
    SELECT * FROM task_1_4;
end;
