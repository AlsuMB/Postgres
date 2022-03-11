CREATE TABLE logged_table(
   id SERIAL PRIMARY KEY,
   content VARCHAR,
   start_time timestamp,
   count int
);

CREATE UNLOGGED TABLE unlogged_table(
   id SERIAL PRIMARY KEY,
   content VARCHAR,
   start_time timestamp,
   count int
);

-- insert script pgbench
INSERT INTO (un)logged_table(content, start_time,count) VALUES ('test_insert', current_timestamp, 1);

-- update script pgbench
UPDATE (un)logged_table
set count = 2
where id = (
   SELECT id
   from (un)logged_table
   where content = 'test_insert'
   limit 1
   )
returning  content;

-- delete script pgbench
DELETE FROM logged_table WHERE ctid in (
   SELECT ctid
   from logged_table
   where content = 'test_insert'
   limit 1
);