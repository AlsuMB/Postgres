CREATE TABLE task_2_1 (
    id serial primary key,
    content varchar(100),
    start timestamp
) WITH (FILLFACTOR = 50);

CREATE TABLE task_2_2 (
    id serial primary key,
    content varchar(100),
    start timestamp
) WITH (FILLFACTOR = 75);

CREATE TABLE task_2_3 (
    id serial primary key,
    content varchar(100),
    start timestamp
) WITH (FILLFACTOR = 90);

CREATE TABLE task_2_4 (
    id serial primary key,
    content varchar(100),
    start timestamp
) WITH (FILLFACTOR = 100);


DO $$
BEGIN
FOR i in 1..10000
    LOOP
    INSERT INTO task_1_1(content) VALUES (array_to_string(array(select substr('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',((random()*(36-1)+1)::integer),1) from generate_series(1,50)),''));
    end loop;
end $$;

UPDATE task_2_1
SET content = concat(content, content);

UPDATE task_2_2
SET content = concat(content, content);

UPDATE task_2_3
SET content = concat(content, content);

UPDATE task_2_4
SET content = concat(content, content);

-- Pgbench scripts

begin;
    SELECT * FROM task_2_1 WHERE content = 'content';
    SELECT * FROM task_2_2 WHERE content = 'content';
    SELECT * FROM task_2_3 WHERE content = 'content';
    SELECT * FROM task_2_4 WHERE content = 'content';
end;

begin;
    UPDATE task_2_1 SET start = start - interval '1 year';
    UPDATE task_2_2 SET start = start - interval '1 year';
    UPDATE task_2_3 SET start = start - interval '1 year';
    UPDATE task_2_4 SET start = start - interval '1 year';
end;
